import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

class CalendarSyncService {
  static final CalendarSyncService _instance = CalendarSyncService._internal();
  factory CalendarSyncService() => _instance;
  CalendarSyncService._internal();

  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  String? _selectedCalendarId;

  Future<void> init() async {
    tz.initializeTimeZones();
  }

  Future<bool> requestPermissions() async {
    // 1. 首先尝试请求通用的日历权限
    var status = await Permission.calendar.request();
    if (status.isGranted) return true;

    // 2. 如果是 Android 14+，尝试请求 Full Access
    status = await Permission.calendarFullAccess.request();
    if (status.isGranted) return true;

    // 3. 检查插件自带的权限判断（作为保底）
    final pluginRes = await _deviceCalendarPlugin.hasPermissions();
    if (pluginRes.isSuccess && pluginRes.data!) return true;
    
    final pluginReq = await _deviceCalendarPlugin.requestPermissions();
    if (pluginReq.isSuccess && pluginReq.data!) return true;

    // 4. 如果被永久拒绝，建议引导用户去设置页
    if (await Permission.calendar.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  Future<List<Calendar>> getCalendars() async {
    final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
    return calendarsResult.isSuccess ? calendarsResult.data ?? [] : [];
  }

  void setSelectedCalendar(String id) {
    _selectedCalendarId = id;
  }

  Future<void> saveTargetCalendar(String id) async {
    setSelectedCalendar(id);
  }

  Future<String?> addEvent({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    String? description,
  }) async {
    if (_selectedCalendarId == null) return null;

    final event = Event(
      _selectedCalendarId,
      title: title,
      start: tz.TZDateTime.from(startTime, tz.local),
      end: tz.TZDateTime.from(endTime, tz.local),
      description: description ?? '由教务管理助手同步',
    );

    final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    return (result?.isSuccess ?? false) ? result?.data : null;
  }

  Future<String?> syncSchedule(Schedule schedule, String studentName) async {
    if (_selectedCalendarId == null) return null;

    final event = Event(
      _selectedCalendarId,
      eventId: schedule.systemEventId,
      title: studentName,
      start: tz.TZDateTime.from(schedule.startTime, tz.local),
      end: tz.TZDateTime.from(schedule.endTime, tz.local),
      description: '由教务管理助手同步',
    );

    final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    return (result?.isSuccess ?? false) ? result?.data : null;
  }

  Future<void> deleteEvent(String? eventId) async {
    if (_selectedCalendarId == null || eventId == null) return;
    await _deviceCalendarPlugin.deleteEvent(_selectedCalendarId, eventId);
  }

  // 双向同步：从系统日历拉取变更并更新本地数据库
  Future<int> pullFromSystem(AppDatabase db) async {
    if (_selectedCalendarId == null) return 0;

    // 1. 获取本地有同步记录的日程
    final localSchedules = await (db.select(db.schedules)
          ..where((s) => s.systemEventId.isNotNull()))
        .get();
    if (localSchedules.isEmpty) return 0;

    // 2. 确定查询的时间范围（过去1个月到未来3个月）
    final now = DateTime.now();
    final rangeStart = now.subtract(const Duration(days: 30));
    final rangeEnd = now.add(const Duration(days: 90));

    // 3. 从系统日历获取该范围内的所有事件
    final eventsResult = await _deviceCalendarPlugin.retrieveEvents(
      _selectedCalendarId,
      RetrieveEventsParams(startDate: rangeStart, endDate: rangeEnd),
    );

    if (!eventsResult.isSuccess || eventsResult.data == null) return 0;

    int updateCount = 0;
    final systemEvents = eventsResult.data!;

    // 4. 建立索引加速匹配
    final Map<String, Event> eventMap = {
      for (var e in systemEvents) if (e.eventId != null) e.eventId!: e
    };

    // 5. 对比并同步
    for (var schedule in localSchedules) {
      final systemEvent = eventMap[schedule.systemEventId];
      
      if (systemEvent != null) {
        // 如果系统日历里的时间变了，更新本地
        final systemStart = systemEvent.start!;
        final systemEnd = systemEvent.end!;
        
        if (systemStart.isAtSameMomentAs(schedule.startTime) && 
            systemEnd.isAtSameMomentAs(schedule.endTime)) {
          continue;
        }

        // 检查是否存在时间冲突（排除自身）
        final hasConflict = await db.hasScheduleConflict(
          systemStart, 
          systemEnd, 
          excludeId: schedule.id
        );

        if (!hasConflict) {
          await (db.update(db.schedules)..where((s) => s.id.equals(schedule.id))).write(
            SchedulesCompanion(
              startTime: Value(systemStart),
              endTime: Value(systemEnd),
            ),
          );
          updateCount++;
        }
      }
    }
    return updateCount;
  }
}

final calendarService = CalendarSyncService();

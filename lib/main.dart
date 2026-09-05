import 'package:flutter/material.dart' hide SelectionDetails;
import 'package:drift/drift.dart' hide Column;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'app_database.dart';
import 'calendar_service.dart';
import 'csv_import_service.dart';
import 'package:device_calendar/device_calendar.dart' as dev_cal;
import 'package:flutter_slidable/flutter_slidable.dart';

final database = AppDatabase();

String _getWeekday(DateTime date) {
  const weekdays = ['一', '二', '三', '四', '五', '六', '日'];
  return '周${weekdays[date.weekday - 1]}';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await calendarService.init();
  runApp(const EduApp());
}

class EduApp extends StatelessWidget {
  const EduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '教务管理助手',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFE89E6B),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F5EE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Color(0xFF4A453E), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFE89E6B).withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Color(0xFFE89E6B), fontWeight: FontWeight.bold, fontSize: 12);
            }
            return const TextStyle(color: Color(0xFFBAB3A9), fontSize: 12);
          }),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => const [
    HomePage(),
    ScheduleCalendarPage(),
    StudentListPage(),
    StatsDashboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: StreamBuilder<List<CoursePack>>(
        stream: (database.select(database.coursePacks).join([
          innerJoin(database.students, database.students.id.equalsExp(database.coursePacks.studentId))
        ])..where(database.students.isArchived.equals(false) & database.students.isSuspended.equals(false))).watch().map((rows) => rows.map((row) => row.readTable(database.coursePacks)).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('加载失败: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final lowLessonCount = snapshot.data?.where((p) => p.remainingLessons <= 2).length ?? 0;

          return NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) => setState(() => _currentIndex = index),
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: '首页',
              ),
              const NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: '课表',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text(lowLessonCount.toString()),
                  isLabelVisible: lowLessonCount > 0,
                  child: const Icon(Icons.people_outline),
                ),
                selectedIcon: Badge(
                  label: Text(lowLessonCount.toString()),
                  isLabelVisible: lowLessonCount > 0,
                  child: const Icon(Icons.people),
                ),
                label: '学员',
              ),
              const NavigationDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: '统计',
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return '凌晨好';
    if (hour < 11) return '早安';
    if (hour < 14) return '中午好';
    if (hour < 18) return '下午好';
    return '晚上好';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFE89E6B),
                        radius: 18,
                        child: Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_getGreeting()}，任老师',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4A453E)),
                      ),
                    ],
                  ),
                  StreamBuilder<List<Schedule>>(
                    stream: (database.select(database.schedules).join([
                      innerJoin(database.students, database.students.id.equalsExp(database.schedules.studentId))
                    ])..where(database.students.isArchived.equals(false) &
                    database.students.isSuspended.equals(false) &
                    database.schedules.startTime.isBiggerOrEqualValue(todayStart) &
                    database.schedules.startTime.isSmallerThanValue(todayEnd) &
                    database.schedules.status.isNotIn([ScheduleStatus.studentLeave.index])))
                        .watch().map((rows) => rows.map((row) => row.readTable(database.schedules)).toList()),
                    builder: (context, snapshot) {
                      final count = snapshot.data?.length ?? 0;
                      return Tooltip(
                        message: '不计入已删除排课和加入回收站的学员排课',
                        triggerMode: TooltipTriggerMode.tap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('今日 $count 节课', style: const TextStyle(fontSize: 12, color: Color(0xFF8B8479))),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              StreamBuilder<List<Schedule>>(
                stream: (database.select(database.schedules).join([
                  innerJoin(database.students, database.students.id.equalsExp(database.schedules.studentId))
                ])..where(database.students.isArchived.equals(false) &
                database.students.isSuspended.equals(false) &
                database.schedules.startTime.isSmallerOrEqualValue(now) &
                database.schedules.endTime.isBiggerThanValue(now) &
                database.schedules.status.equals(ScheduleStatus.scheduled.index)))
                    .watch().map((rows) => rows.map((row) => row.readTable(database.schedules)).toList()),
                builder: (context, snapshot) {
                  final activeSchedules = snapshot.data ?? [];
                  if (activeSchedules.isEmpty) return const SizedBox.shrink();

                  final currentSchedule = activeSchedules.first;
                  return FutureBuilder(
                    future: Future.wait([
                      (database.select(database.students)..where((s) => s.id.equals(currentSchedule.studentId))).getSingle(),
                      currentSchedule.coursePackId != null
                          ? (database.select(database.coursePacks)..where((p) => p.id.equals(currentSchedule.coursePackId!))).getSingleOrNull()
                          : Future.value(null),
                    ]),
                    builder: (context, AsyncSnapshot<List<dynamic>> dataSnapshot) {
                      if (!dataSnapshot.hasData) return const SizedBox.shrink();
                      final student = dataSnapshot.data![0] as Student;
                      final pack = dataSnapshot.data![1] as CoursePack?;

                      final totalDuration = currentSchedule.endTime.difference(currentSchedule.startTime).inMinutes;
                      final elapsed = DateTime.now().difference(currentSchedule.startTime).inMinutes;
                      final progress = (elapsed / totalDuration).clamp(0.0, 1.0);

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE89E6B).withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(color: Color(0xFFE89E6B), shape: BoxShape.circle),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('上课中', style: TextStyle(color: Color(0xFFE89E6B), fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text(
                                  '${DateFormat('HH:mm').format(currentSchedule.startTime)} - ${DateFormat('HH:mm').format(currentSchedule.endTime)}',
                                  style: const TextStyle(color: Color(0xFFBAB3A9), fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${student.name} · ${pack?.courseName ?? "临时课程"}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A453E)),
                            ),
                            const SizedBox(height: 4),
                            Text('已上 $elapsed 分钟', style: const TextStyle(fontSize: 13, color: Color(0xFF8B8479))),
                            const SizedBox(height: 16),
                            Stack(
                              children: [
                                Container(
                                  height: 6,
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: const Color(0xFFF1EDE4), borderRadius: BorderRadius.circular(3)),
                                ),
                                FractionallySizedBox(
                                  widthFactor: progress,
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(color: const Color(0xFFE89E6B), borderRadius: BorderRadius.circular(3)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: const Color(0xFFBAB3A9).withValues(alpha: 0.2),
                                  child: const Icon(Icons.person, size: 12, color: Color(0xFF8B8479)),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${student.name} · ${student.phone ?? "暂无电话"}',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF8B8479)),
                                ),
                                const Spacer(),
                                Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 12, color: Color(0xFFBAB3A9), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Text(
                '我的待办',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A453E)),
              ),
              const SizedBox(height: 16),
              _buildTodoCard(
                icon: Icons.calendar_today_outlined,
                iconColor: const Color(0xFFE89E6B),
                title: '未签到',
                stream: (database.select(database.schedules).join([
                  innerJoin(database.students, database.students.id.equalsExp(database.schedules.studentId))
                ])..where(database.students.isArchived.equals(false) &
                database.students.isSuspended.equals(false) &
                database.schedules.startTime.isSmallerThanValue(now) &
                database.schedules.status.equals(ScheduleStatus.scheduled.index)))
                    .watch().map((rows) => rows.map((row) => row.readTable(database.schedules)).toList()),
                subtitleBuilder: (count) => count > 0 ? '$count 节课待签到' : '全部处理完毕',
                detail: '待处理',
              ),
              const SizedBox(height: 12),
              _buildTodoCard(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xFF7E9A96),
                title: '续费提醒',
                stream: (database.select(database.coursePacks).join([
                  innerJoin(database.students, database.students.id.equalsExp(database.coursePacks.studentId))
                ])..where(database.students.isArchived.equals(false) &
                database.students.isSuspended.equals(false) &
                database.coursePacks.remainingLessons.isSmallerOrEqualValue(2)))
                    .watch().map((rows) => rows.map((row) => row.readTable(database.coursePacks)).toList()),
                subtitleBuilder: (count) => count > 0 ? '$count 项待续费' : '暂无低余额学员',
                detail: '7天内到期',
                showCountBadge: true,
              ),
              const SizedBox(height: 12),
              _buildTodoCard(
                icon: Icons.error_outline_rounded,
                iconColor: Colors.red,
                title: '欠课超上',
                stream: (database.select(database.students).join([
                  innerJoin(database.studentCourseTypeDebts, database.studentCourseTypeDebts.studentId.equalsExp(database.students.id))
                ])..where(database.students.isArchived.equals(false) & database.studentCourseTypeDebts.debtAmount.isBiggerThanValue(0)))
                    .watch().map((rows) => rows.map((r) => r.readTable(database.students)).toSet().toList()),
                subtitleBuilder: (count) => count > 0 ? '$count 位学员欠课' : '暂无欠课学员',
                detail: '需及时续费',
                showCountBadge: true,
              ),
              const SizedBox(height: 12),
              _buildTodoCard(
                icon: Icons.cake_outlined,
                iconColor: const Color(0xFFD48B8B),
                title: '生日提醒',
                stream: Stream.value([]),
                subtitleBuilder: (count) => '今天暂无学员生日',
                detail: '提前准备祝福',
              ),
              const SizedBox(height: 32),
              const Text(
                '数据统计',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A453E)),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('近 7 天课时', style: TextStyle(fontSize: 15, color: Color(0xFF4A453E))),
                    Row(
                      children: [
                        Text('更多数据', style: TextStyle(fontSize: 13, color: Color(0xFFBAB3A9))),
                        Icon(Icons.chevron_right, size: 18, color: Color(0xFFBAB3A9)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Stream stream,
    required String Function(int) subtitleBuilder,
    required String detail,
    bool showCountBadge = false,
    int? countOverride,
  }) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final count = countOverride ?? (snapshot.data is List ? (snapshot.data as List).length : 0);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: iconColor, size: 24)),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFFBAB3A9))),
                const SizedBox(height: 2),
                Text(subtitleBuilder(count), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A453E))),
                const SizedBox(height: 2),
                Text(detail, style: const TextStyle(fontSize: 12, color: Color(0xFFBAB3A9))),
              ])),
              if (count > 0) Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: iconColor)),
            ],
          ),
        );
      },
    );
  }
}

class ScheduleCalendarPage extends StatefulWidget {
  const ScheduleCalendarPage({super.key});

  @override
  State<ScheduleCalendarPage> createState() => _ScheduleCalendarPageState();
}

class _ScheduleCalendarPageState extends State<ScheduleCalendarPage> {
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('排课日历'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => _showCalendarSyncDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<List<Schedule>>(
        stream: (database.select(database.schedules).join([
          innerJoin(database.students, database.students.id.equalsExp(database.schedules.studentId))
        ])..where(database.students.isArchived.equals(false) & database.students.isSuspended.equals(false)))
            .watch().map((rows) => rows.map((row) => row.readTable(database.schedules)).toList()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return FutureBuilder<List<Appointment>>(
            future: _convertToAppointments(snapshot.data!),
            builder: (context, apptSnapshot) {
              if (!apptSnapshot.hasData) return const Center(child: CircularProgressIndicator());
              return SfCalendar(
                view: CalendarView.week,
                dataSource: _ScheduleDataSource(apptSnapshot.data!),
                controller: _calendarController,
                headerHeight: 50,
                todayHighlightColor: const Color(0xFFE89E6B),
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: const Color(0xFFE89E6B), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                onTap: (details) {
                  if (details.targetElement == CalendarElement.appointment) {
                    _showScheduleOptions(context, details.appointments!.first.id);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScheduleDialog(context),
        backgroundColor: const Color(0xFFE89E6B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }



  Future<List<Appointment>> _convertToAppointments(List<Schedule> schedules) async {
    final List<Appointment> appointments = [];
    for (var s in schedules) {
      final student = await (database.select(database.students)..where((st) => st.id.equals(s.studentId))).getSingleOrNull();
      if (student == null || student.isArchived) continue;
      CoursePack? pack;
      if (s.coursePackId != null) {
        pack = await (database.select(database.coursePacks)..where((p) => p.id.equals(s.coursePackId!))).getSingleOrNull();
      }
      
      String typeName = "日常日程";
      final typeId = s.courseTypeId ?? pack?.courseTypeId;
      if (typeId != null) {
        final ct = await (database.select(database.courseTypes)..where((t) => t.id.equals(typeId))).getSingleOrNull();
        if (ct != null) typeName = ct.name;
      }

      Color color = const Color(0xFFE89E6B);
      if (s.status == ScheduleStatus.completed) color = const Color(0xFF7E9A96);
      if (s.status == ScheduleStatus.studentLeave) color = const Color(0xFFD48B8B);
      appointments.add(Appointment(
        id: s.id,
        startTime: s.startTime,
        endTime: s.endTime,
        subject: student.name,
        color: color.withValues(alpha: 0.8),
        notes: pack != null ? '${pack.courseName} ($typeName)' : typeName,
      ));
    }
    return appointments;
  }

  void _showScheduleOptions(BuildContext context, int scheduleId) async {
    final schedule = await (database.select(database.schedules)..where((s) => s.id.equals(scheduleId))).getSingleOrNull();
    if (schedule == null) return;
    final student = await (database.select(database.students)..where((s) => s.id.equals(schedule.studentId))).getSingleOrNull();
    if (student == null) return;
    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(student.name),
            subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(schedule.startTime)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(ctx);
              Navigator.push(context, MaterialPageRoute(builder: (c) => StudentDetailPage(student: student)));
            },
          ),
          const Divider(),
          if (schedule.status == ScheduleStatus.scheduled) ...[
            ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Color(0xFF7E9A96)),
              title: const Text('消课 (签到)'),
              subtitle: const Text('执行扣费并完成排课'),
              onTap: () async {
                Navigator.pop(ctx);
                try {
                  await database.executeCheckIn(scheduleId: scheduleId);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.beach_access_outlined, color: Color(0xFFD48B8B)),
              title: const Text('学员请假'),
              onTap: () async {
                Navigator.pop(ctx);
                await database.markStudentLeave(scheduleId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_calendar_outlined, color: Colors.blue),
              title: const Text('修改上课时间'),
              onTap: () {
                Navigator.pop(ctx);
                _showEditTimeDialog(context, schedule, student.name);
              },
            ),
          ],
          if (schedule.status != ScheduleStatus.scheduled)
            ListTile(
              leading: const Icon(Icons.settings_backup_restore, color: Colors.orange),
              title: const Text('撤销状态'),
              subtitle: const Text('还原为待上课并退回课时'),
              onTap: () async {
                Navigator.pop(ctx);
                await database.revertScheduleStatus(scheduleId);
              },
            ),
          ListTile(leading: const Icon(Icons.delete_outline, color: Colors.red), title: const Text('删除排课'), onTap: () async {
            Navigator.pop(ctx);
            
            final onlyThis = await showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: const Text('删除确认'),
                content: Text(schedule.recurringGroupId != null 
                  ? '这是一个循环排课系列，您想如何删除？' 
                  : '您想仅删除当前这一节课，还是删除该学员后续所有的【${_getWeekday(schedule.startTime)}】同类课程？'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(c, null), child: const Text('取消')),
                  TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('仅此次')),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(c, false), 
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), 
                    child: const Text('此次及以后')
                  ),
                ],
              ),
            );

            if (onlyThis != null) {
              try {
                if (schedule.systemEventId != null) {
                  await calendarService.deleteEvent(schedule.systemEventId!);
                }
                await database.deleteSchedule(scheduleId, onlyThis: onlyThis);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('删除成功')));
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('删除失败: $e')));
                }
              }
            }
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showEditTimeDialog(BuildContext context, Schedule schedule, String studentName) async {
    DateTime newStart = schedule.startTime;
    int durationMinutes = 45;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('修改上课时间'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text('日期'), subtitle: Text(DateFormat('yyyy-MM-dd').format(newStart)), trailing: const Icon(Icons.calendar_today), onTap: () async {
                final date = await showDatePicker(context: context, initialDate: newStart, firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 365 * 2)));
                if (date != null) setDialogState(() => newStart = DateTime(date.year, date.month, date.day, newStart.hour, newStart.minute));
              }),
              ListTile(title: const Text('开始时间'), subtitle: Text(DateFormat('HH:mm').format(newStart)), trailing: const Icon(Icons.access_time), onTap: () async {
                final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(newStart));
                if (time != null) setDialogState(() => newStart = DateTime(newStart.year, newStart.month, newStart.day, time.hour, time.minute));
              }),
              DropdownButtonFormField<int>(value: durationMinutes, decoration: const InputDecoration(labelText: '上课时长'), items: [30, 45, 60, 90, 120].map((m) => DropdownMenuItem(value: m, child: Text('$m 分钟'))).toList(), onChanged: (v) => setDialogState(() => durationMinutes = v!)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
            ElevatedButton(onPressed: () async {
              final newEnd = newStart.add(Duration(minutes: durationMinutes));
              try {
                await database.updateScheduleTime(schedule.id, newStart, newEnd);
                final updated = await (database.select(database.schedules)..where((s) => s.id.equals(schedule.id))).getSingle();
                final sysId = await calendarService.syncSchedule(updated, studentName);
                if (sysId != null && updated.systemEventId == null) await (database.update(database.schedules)..where((s) => s.id.equals(schedule.id))).write(SchedulesCompanion(systemEventId: Value(sysId)));
                if (context.mounted) Navigator.pop(ctx);
              } catch (e) {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, child: const Text('保存')),
          ],
        ),
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) async {
    final students = await (database.select(database.students)..where((s) => s.isArchived.equals(false) & s.isSuspended.equals(false))).get();
    final courseTypes = await database.select(database.courseTypes).get();
    if (students.isEmpty) return;

    int? selectedStudentId; 
    int? selectedCourseTypeId = courseTypes.isNotEmpty ? courseTypes.first.id : null;
    bool isTrial = false;
    final trialNameController = TextEditingController(); // 初始文本为空
    int durationMinutes = 45;
    int repeatWeeks = 52;
    bool enableRecurring = true;
    bool showAdvance = false;

    List<CoursePack> currentPacks = [];
    int? selectedPackId;
    DateTime selectedDay = _calendarController.selectedDate ?? DateTime.now();
    Map<int, TimeOfDay> weekdayTimeMap = {selectedDay.weekday: TimeOfDay(hour: selectedDay.hour, minute: selectedDay.minute == 0 ? 0 : selectedDay.minute)};
    const weekdaysText = ['一', '二', '三', '四', '五', '六', '日'];

    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => Container(
          // 容器高度设为屏幕 85%，确保有足够空间滚动
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F5EE), 
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // 关键：利用原生 Scaffold 的能力来处理键盘上推，性能远高于手动 Padding
            resizeToAvoidBottomInset: true,
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: showAdvance 
                ? _buildRecurringSettingsView(
                    context, selectedDay, weekdayTimeMap, repeatWeeks, weekdaysText,
                    onBack: () => setDialogState(() => showAdvance = false),
                    onUpdate: (map, weeks) => setDialogState(() {
                      weekdayTimeMap = map;
                      repeatWeeks = weeks;
                    }),
                  )
                : _buildMainScheduleView(
                    context, setDialogState, selectedDay, weekdayTimeMap, durationMinutes,
                    selectedStudentId, selectedPackId, students, currentPacks, 
                    isTrial, trialNameController, enableRecurring, repeatWeeks,
                    onTrialChanged: (v) => setDialogState(() => isTrial = v),
                    onRecurringChanged: (v) => setDialogState(() => enableRecurring = v),
                    onStudentChanged: (id, packs, packId) => setDialogState(() {
                      selectedStudentId = id;
                      currentPacks = packs;
                      selectedPackId = packId;
                    }),
                    onDateChanged: (v) => setDialogState(() {
                      final oldTime = weekdayTimeMap[selectedDay.weekday] ?? const TimeOfDay(hour: 14, minute: 0);
                      selectedDay = v;
                      // 确保新选日期的初始时间与之前一致
                      weekdayTimeMap[v.weekday] = oldTime;
                    }),
                    onPackChanged: (v) => setDialogState(() => selectedPackId = v),
                    onDurationChanged: (v) => setDialogState(() => durationMinutes = v),
                    onToggleAdvance: () => setDialogState(() => showAdvance = true),
                    selectedCourseTypeId: selectedCourseTypeId,
                    courseTypes: courseTypes,
                    onCourseTypeChanged: (v) => setDialogState(() => selectedCourseTypeId = v),
                    onConfirm: (totalWeeks, validSlots, studentId, packId, typeId) async {
                      await _batchInsertSchedules(validSlots, studentId, packId, typeId);
                      if (context.mounted) Navigator.pop(ctx);
                    },
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainScheduleView(
    BuildContext context, StateSetter setDialogState, DateTime selectedDay, Map<int, TimeOfDay> weekdayTimeMap, int durationMinutes, int? selectedStudentId, int? selectedPackId, List<Student> students, List<CoursePack> currentPacks, bool isTrial, TextEditingController trialNameController, bool enableRecurring, int repeatWeeks, 
    {required ValueChanged<bool> onTrialChanged, required ValueChanged<bool> onRecurringChanged, required ValueChanged<DateTime> onDateChanged, required Function(int, List<CoursePack>, int?) onStudentChanged, required ValueChanged<int?> onPackChanged, required ValueChanged<int> onDurationChanged, required VoidCallback onToggleAdvance, required int? selectedCourseTypeId, required List<CourseType> courseTypes, required ValueChanged<int?> onCourseTypeChanged, required Function onConfirm}
  ) {
    final startTime = weekdayTimeMap[selectedDay.weekday] ?? const TimeOfDay(hour: 14, minute: 0);
    return SingleChildScrollView(
      // 增加滚动支持，防止键盘弹出时溢出
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, margin: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('排课详情', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF4A453E))),
                const SizedBox(height: 16),
                
                // 1. 时间要素卡片 (RepaintBoundary 优化)
                RepaintBoundary(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: selectedDay,
                              firstDate: DateTime.now().subtract(const Duration(days: 365)),
                              lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                            );
                            if (d != null) onDateChanged(d);
                          },
                          child: Row(children: [
                            const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFFE89E6B)),
                            const SizedBox(width: 10),
                            Text(
                              '${DateFormat('yyyy年MM月dd日').format(selectedDay)} ${_getWeekday(selectedDay)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A453E)),
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.grey),
                          ]),
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                        Row(children: [
                          Expanded(child: InkWell(onTap: () async { final p = await showTimePicker(context: context, initialTime: startTime); if (p != null) setDialogState(() => weekdayTimeMap[selectedDay.weekday] = p); }, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('开始时间', style: TextStyle(fontSize: 12, color: Colors.grey)), Text(startTime.format(context), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFFE89E6B)))]))),
                          Container(width: 1, height: 30, color: Colors.grey.shade200),
                          Expanded(child: Padding(padding: const EdgeInsets.only(left: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('时长', style: TextStyle(fontSize: 12, color: Colors.grey)), DropdownButton<int>(value: durationMinutes, isExpanded: true, underline: const SizedBox(), items: [45, 60, 90, 120].map((m) => DropdownMenuItem(value: m, child: Text('$m 分钟'))).toList(), onChanged: (v) => onDurationChanged(v!))]))),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // 2. 学员选择卡片 (RepaintBoundary 优化)
                RepaintBoundary(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('上课学员', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 8),
                        Autocomplete<Student>(
                          initialValue: TextEditingValue(text: isTrial ? trialNameController.text : (selectedStudentId != null ? students.firstWhere((s) => s.id == selectedStudentId).name : "")),
                          displayStringForOption: (Student s) => s.name,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) return const Iterable<Student>.empty();
                            return students.where((s) => s.name.contains(textEditingValue.text));
                          },
                          onSelected: (Student s) async {
                            onTrialChanged(false);
                            final packs = await (database.select(database.coursePacks)..where((pk) => pk.studentId.equals(s.id))).get();
                            onStudentChanged(s.id, packs, packs.isNotEmpty ? packs.first.id : null);
                          },
                          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText: '输入姓名或点击右侧匿名',
                                filled: true,
                                fillColor: const Color(0xFFF8F5EE),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.person_search_rounded, color: Color(0xFFE89E6B)),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.person_add_disabled_outlined, size: 20, color: Color(0xFF8B8479)),
                                  tooltip: '匿名试课',
                                  onPressed: () {
                                    controller.text = '试课学员(待定)';
                                    trialNameController.text = '试课学员(待定)';
                                    onTrialChanged(true);
                                  },
                                ),
                                isDense: true,
                              ),
                              onChanged: (val) {
                                trialNameController.text = val;
                                onTrialChanged(true); 
                              },
                            );
                          },
                        ),
                        if (isTrial) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.info_outline, size: 14, color: Colors.orange),
                              const SizedBox(width: 4),
                              const Text('当前为试课模式：此姓名将作为临时学员排课', style: TextStyle(fontSize: 10, color: Colors.orange)),
                            ],
                          ),
                        ],
                        if (selectedStudentId != null && !isTrial) ...[
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int?>(
                            value: selectedPackId, 
                            decoration: const InputDecoration(labelText: '扣减课程包', border: OutlineInputBorder(), isDense: true), 
                            items: [
                              const DropdownMenuItem(value: null, child: Text('不绑定 (记录日程)')), 
                              ...currentPacks.map((p) => DropdownMenuItem(value: p.id, child: Text(p.courseName)))
                            ], 
                            onChanged: (v) {
                              onPackChanged(v);
                              if (v != null) {
                                final pack = currentPacks.firstWhere((p) => p.id == v);
                                if (pack.courseTypeId != null) onCourseTypeChanged(pack.courseTypeId);
                              }
                            }
                          ),
                        ],
                        const SizedBox(height: 12),
                        DropdownButtonFormField<int?>(
                          value: selectedCourseTypeId,
                          decoration: const InputDecoration(labelText: '课程类型', border: OutlineInputBorder(), isDense: true),
                          items: courseTypes.map((t) => DropdownMenuItem(value: t.id, child: Text(t.name))).toList(),
                          onChanged: onCourseTypeChanged,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => onRecurringChanged(!enableRecurring), 
                  child: Container(
                    padding: const EdgeInsets.all(16), 
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), 
                    child: Row(
                      children: [
                        Icon(Icons.repeat, color: enableRecurring ? const Color(0xFFE89E6B) : Colors.grey), 
                        const SizedBox(width: 12), 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            const Text('周期性重复'), 
                            Text(enableRecurring ? '持续 $repeatWeeks 周' : '不重复', style: const TextStyle(fontSize: 11, color: Colors.grey))
                          ],
                        ), 
                        const Spacer(), 
                        if (enableRecurring) 
                          TextButton(onPressed: onToggleAdvance, child: const Text('去设置')), 
                        Switch.adaptive(
                          value: enableRecurring, 
                          activeColor: const Color(0xFFE89E6B), 
                          onChanged: onRecurringChanged,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, height: 56, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A453E), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), onPressed: () async {
                  int? finalStudentId = selectedStudentId;
                  if (isTrial) {
                    final name = trialNameController.text.trim();
                    if (name.isEmpty) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请先输入或选择学员')));
                      }
                      return;
                    }
                    final exist = await (database.select(database.students)..where((s) => s.name.equals(name))).getSingleOrNull();
                    if (exist != null) {
                      finalStudentId = exist.id;
                    } else {
                      finalStudentId = await database.into(database.students).insert(StudentsCompanion.insert(name: name, isTrial: const Value(true)));
                    }
                  }

                  if (finalStudentId == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请选择学员')));
                    }
                    return;
                  }

                  final slots = await _calculateValidSlots(selectedDay, weekdayTimeMap, durationMinutes, enableRecurring ? repeatWeeks : 1);
                  onConfirm(enableRecurring ? repeatWeeks : 1, slots, finalStudentId, selectedPackId, selectedCourseTypeId);
                }, child: Text(enableRecurring ? '批量生成课程' : '确认排课', style: const TextStyle(fontWeight: FontWeight.bold)))),
                const SizedBox(height: 8), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringSettingsView(BuildContext context, DateTime selectedDay, Map<int, TimeOfDay> weekdayTimeMap, int repeatWeeks, List<String> weekdaysText, {required VoidCallback onBack, required Function(Map<int, TimeOfDay>, int) onUpdate}) {
    return Column(
      children: [
        AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: onBack), title: const Text('重复周期设置'), backgroundColor: Colors.transparent, elevation: 0),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('上课日 (多选)', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                Wrap(spacing: 10, runSpacing: 10, children: List.generate(7, (i) {
                  final d = i + 1; final sel = weekdayTimeMap.containsKey(d);
                  return FilterChip(label: Text('周${weekdaysText[i]}'), selected: sel, onSelected: (s) { 
                    final m = Map<int, TimeOfDay>.from(weekdayTimeMap); 
                    if (s) {
                      m[d] = weekdayTimeMap.values.isNotEmpty ? weekdayTimeMap.values.first : const TimeOfDay(hour: 14, minute: 0); 
                    } else if (m.length > 1) {
                      m.remove(d); 
                    }
                    onUpdate(m, repeatWeeks); 
                  });
                })),
                const SizedBox(height: 24),
                const Text('各天时间段', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                ...(weekdayTimeMap.entries.toList()..sort((a, b) => a.key.compareTo(b.key))).map((e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('周${weekdaysText[e.key - 1]}'),
                  trailing: InkWell(
                    onTap: () async {
                      final t = await showTimePicker(context: context, initialTime: e.value);
                      if (t != null) {
                        final m = Map<int, TimeOfDay>.from(weekdayTimeMap);
                        m[e.key] = t;
                        onUpdate(m, repeatWeeks);
                      }
                    },
                    child: Text(e.value.format(context), style: const TextStyle(color: Color(0xFFE89E6B), fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                )),
                const SizedBox(height: 24),
                const Text('持续周数', style: TextStyle(color: Colors.grey)),
                DropdownButtonFormField<int>(value: repeatWeeks, items: [4, 12, 24, 52].map((w) => DropdownMenuItem(value: w, child: Text('$w 周'))).toList(), onChanged: (v) => onUpdate(weekdayTimeMap, v!)),
                const SizedBox(height: 40),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE89E6B), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: onBack, child: const Text('完成设置'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, DateTime>>> _calculateValidSlots(DateTime selectedDay, Map<int, TimeOfDay> weekdayTimeMap, int durationMinutes, int totalWeeks) async {
    final List<Map<String, DateTime>> validSlots = [];
    final baseMon = DateTime(selectedDay.year, selectedDay.month, selectedDay.day).subtract(Duration(days: selectedDay.weekday - 1));
    for (int w = 0; w < totalWeeks; w++) {
      for (int dNum in weekdayTimeMap.keys) {
        final target = baseMon.add(Duration(days: (w * 7) + (dNum - 1)));
        if (w == 0 && target.isBefore(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))) continue;
        final time = weekdayTimeMap[dNum]!;
        final start = DateTime(target.year, target.month, target.day, time.hour, time.minute);
        validSlots.add({'start': start, 'end': start.add(Duration(minutes: durationMinutes))});
      }
    }
    return validSlots;
  }

  void _showCalendarSyncDialog(BuildContext context) async {
    final hasP = await calendarService.requestPermissions();
    if (!hasP) return;
    final calendars = await calendarService.getCalendars();
    if (calendars.isEmpty) return;
    if (!context.mounted) return;
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('同步系统日历'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 200, width: double.maxFinite, child: ListView.builder(itemCount: calendars.length, itemBuilder: (c, i) => ListTile(title: Text(calendars[i].name ?? '未命名'), subtitle: Text(calendars[i].accountName ?? ''), onTap: () async { calendarService.setSelectedCalendar(calendars[i].id!); Navigator.pop(ctx); await calendarService.pullFromSystem(database); })))
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消'))],
    ));
  }

  Future<void> _batchInsertSchedules(List<Map<String, DateTime>> slots, int studentId, int? coursePackId, int? courseTypeId) async {
    final student = await (database.select(database.students)..where((s) => s.id.equals(studentId))).getSingle();
    final String? groupId = slots.length > 1 ? 'grp_${DateTime.now().millisecondsSinceEpoch}' : null;
    
    await database.transaction(() async {
      for (var slot in slots) {
        final id = await database.into(database.schedules).insert(
          SchedulesCompanion.insert(
            studentId: studentId,
            coursePackId: Value(coursePackId),
            courseTypeId: Value(courseTypeId),
            startTime: slot['start']!,
            endTime: slot['end']!,
            lessonDeduction: const Value(1.0),
            recurringGroupId: Value(groupId),
          ),
        );
        final news = await (database.select(database.schedules)..where((s) => s.id.equals(id))).getSingle();
        final sysId = await calendarService.syncSchedule(news, student.name);
        if (sysId != null) {
          await (database.update(database.schedules)..where((s) => s.id.equals(id))).write(
            SchedulesCompanion(systemEventId: Value(sysId)),
          );
        }
      }
    });
  }
}

class _ScheduleDataSource extends CalendarDataSource {
  _ScheduleDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学员档案与课时'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.delete_sweep_outlined), tooltip: '学员回收站', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentRecycleBinPage()))),
        ],
      ),
      body: StreamBuilder<List<Student>>(
        stream: (database.select(database.students)..where((s) => s.isArchived.equals(false) & s.isTrial.equals(false))).watch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final students = snapshot.data!;
          if (students.isEmpty) return const Center(child: Text('暂无在读学员，点击右下角录入学员'));
          return ListView.builder(itemCount: students.length, itemBuilder: (context, index) => StudentCard(student: students[index]));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _showAddStudentDialog(context), icon: const Icon(Icons.person_add), label: const Text('录入新学员')),
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final priceController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        scrollable: true, title: const Text('录入新学员'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: '学员姓名', isDense: true, prefixIcon: Icon(Icons.person_outline)), autofocus: true),
          const SizedBox(height: 12),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: '联系电话 (可选)', isDense: true, prefixIcon: Icon(Icons.phone_android_outlined)), keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          TextField(controller: priceController, decoration: const InputDecoration(labelText: '随课付费单价 (可选)', hintText: '如不买课包，每节收多少钱', isDense: true, prefixIcon: Icon(Icons.monetization_on_outlined), suffixText: '元/节'), keyboardType: TextInputType.number),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          ElevatedButton(onPressed: () async {
            final name = nameController.text.trim();
            if (name.isEmpty) return;
            final price = double.tryParse(priceController.text.trim());
            await database.into(database.students).insert(StudentsCompanion.insert(name: name, phone: phoneController.text.trim().isNotEmpty ? Value(phoneController.text.trim()) : const Value(null), payPerLessonPrice: Value(price)));
            if (context.mounted) Navigator.pop(ctx);
          }, child: const Text('保存')),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;
  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetailPage(student: student))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                CircleAvatar(backgroundColor: const Color(0xFFE89E6B).withValues(alpha: 0.1), radius: 20, child: Text(student.name.isNotEmpty ? student.name[0] : '学', style: const TextStyle(color: Color(0xFFE89E6B), fontWeight: FontWeight.bold))),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(student.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF4A453E))),
                  Text('加入于 ${DateFormat('yyyy-MM-dd').format(student.createdAt)}', style: const TextStyle(color: Color(0xFFBAB3A9), fontSize: 11)),
                ]),
                if (student.isSuspended) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFBAB3A9).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: const Text('已停课', style: TextStyle(color: Color(0xFF8B8479), fontSize: 10, fontWeight: FontWeight.bold)))]
              ]),
              const Icon(Icons.chevron_right, size: 20, color: Color(0xFFBAB3A9)),
            ]),
            const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: Color(0xFFF1EDE4))),
            StreamBuilder<List<CoursePack>>(
              stream: (database.select(database.coursePacks)..where((p) => p.studentId.equals(student.id))).watch(),
              builder: (context, snapshot) {
                final packs = snapshot.data ?? [];
                if (packs.isEmpty) return Text(student.payPerLessonPrice != null ? '随课付费: ¥${student.payPerLessonPrice!.toStringAsFixed(0)}/节' : '未分配课时', style: const TextStyle(color: Color(0xFF7E9A96), fontWeight: FontWeight.bold, fontSize: 13));
                return Column(children: packs.map((pack) => Padding(padding: const EdgeInsets.symmetric(vertical: 2.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${pack.courseName}: 余 ${pack.remainingLessons} 节', style: TextStyle(color: pack.remainingLessons <= 2 ? const Color(0xFFD48B8B) : const Color(0xFF7E9A96), fontWeight: FontWeight.bold, fontSize: 13)), Text('¥${pack.unitPrice.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFFBAB3A9), fontSize: 13))]))).toList());
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class StudentRecycleBinPage extends StatelessWidget {
  const StudentRecycleBinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('学员回收站')),
      body: StreamBuilder<List<Student>>(
        stream: (database.select(database.students)..where((s) => s.isArchived.equals(true))).watch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final archived = snapshot.data!;
          if (archived.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.auto_delete_outlined, size: 64, color: Colors.grey.shade400), const SizedBox(height: 12), Text('回收站为空', style: TextStyle(color: Colors.grey.shade600))]));
          return ListView.builder(itemCount: archived.length, itemBuilder: (context, index) {
            final student = archived[index];
            return Card(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.grey.shade200, child: Text(student.name.isNotEmpty ? student.name[0] : '学', style: const TextStyle(color: Colors.black54))),
              title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                OutlinedButton.icon(icon: const Icon(Icons.restore, size: 16), label: const Text('恢复'), onPressed: () async { await (database.update(database.students)..where((s) => s.id.equals(student.id))).write(const StudentsCompanion(isArchived: Value(false))); }),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.delete_forever, color: Colors.red), onPressed: () => _permanentlyDelete(context, student)),
              ]),
            ));
          });
        },
      ),
    );
  }

  void _permanentlyDelete(BuildContext context, Student student) {
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('彻底粉碎确认'), content: Text('将永久抹除学员【${student.name}】的所有数据，确认粉碎吗？'), actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), onPressed: () async {
        await database.transaction(() async {
          await (database.delete(database.checkInLogs)..where((l) => l.studentId.equals(student.id))).go();
          await (database.delete(database.schedules)..where((s) => s.studentId.equals(student.id))).go();
          await (database.delete(database.coursePacks)..where((p) => p.studentId.equals(student.id))).go();
          await (database.delete(database.students)..where((s) => s.id.equals(student.id))).go();
        });
        if (context.mounted) Navigator.pop(ctx);
      }, child: const Text('确认粉碎')),
    ]));
  }
}

class StudentDetailPage extends StatelessWidget {
  final Student student;
  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Student?>(
      stream: (database.select(database.students)..where((s) => s.id.equals(student.id))).watchSingleOrNull(),
      builder: (context, snapshot) {
        final current = snapshot.data ?? student;
        return Scaffold(
          appBar: AppBar(title: Text('${current.name} 的教务档案'), actions: [
            IconButton(icon: const Icon(Icons.edit_outlined), tooltip: '编辑资料', onPressed: () => _showEditStudentInfoDialog(context, current)),
            if (current.isSuspended) IconButton(icon: const Icon(Icons.play_circle_outline, color: Colors.green), onPressed: () => _handleResume(context, current))
            else IconButton(icon: const Icon(Icons.pause_circle_outline, color: Colors.orange), onPressed: () => _handleSuspend(context, current)),
            IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent), onPressed: () => _confirmArchiveStudent(context, current)),
          ]),
          body: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (current.isSuspended) Container(width: double.infinity, margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.orange.shade200)), child: const Row(children: [Icon(Icons.info_outline, color: Colors.orange), SizedBox(width: 12), Expanded(child: Text('该学员目前处于【长期停课】状态。未来排课已清空。', style: TextStyle(color: Colors.orange)))])) ,
            Card(elevation: 2, child: Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [
              CircleAvatar(radius: 28, backgroundColor: current.isSuspended ? Colors.grey.shade200 : Colors.indigo.shade100, child: Text(current.name.isNotEmpty ? current.name[0] : '学', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: current.isSuspended ? Colors.grey : Colors.indigo))),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(current.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                if (current.isTrial) Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Row(
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.red.shade200)), child: const Text('试课学员', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold))),
                      const SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 20), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () async {
                          await (database.update(database.students)..where((s) => s.id.equals(current.id))).write(const StudentsCompanion(isTrial: Value(false)));
                        },
                        child: const Text('转为正式', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ),
                Text('加入时间：${DateFormat('yyyy-MM-dd').format(current.createdAt)}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                Wrap(spacing: 12, children: [
                  StreamBuilder<List<CheckInLog>>(stream: (database.select(database.checkInLogs)..where((l) => l.studentId.equals(current.id) & l.remarks.equals("历史导入记录").not())).watch(), builder: (context, snap) => _buildTinyStat('累计上课', '${(current.initialAccumulatedLessons + (snap.data?.length ?? 0)).toStringAsFixed(0)}次', Colors.green)),
                  StreamBuilder<List<TypedResult>>(
                    stream: (database.select(database.studentCourseTypeDebts).join([
                      innerJoin(database.courseTypes, database.courseTypes.id.equalsExp(database.studentCourseTypeDebts.courseTypeId))
                    ])..where(database.studentCourseTypeDebts.studentId.equals(current.id) & database.studentCourseTypeDebts.debtAmount.isBiggerThanValue(0))).watch(),
                    builder: (context, snap) {
                      final debts = snap.data ?? [];
                      if (debts.isEmpty) return const SizedBox.shrink();
                      double total = 0;
                      for (var d in debts) { total += d.readTable(database.studentCourseTypeDebts).debtAmount; }
                      return _buildTinyStat('累计超上', '${total.toStringAsFixed(1)}节', Colors.red);
                    }
                  ),
                  if (current.payPerLessonPrice != null) _buildTinyStat('随课单价', '¥${current.payPerLessonPrice!.toStringAsFixed(0)}', Colors.blue),
                ]),
              ])),
            ]))),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('课时资产', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), FilledButton.icon(onPressed: current.isSuspended ? null : () => _showAddOrRechargeCoursePackDialog(context, current), icon: const Icon(Icons.add_card, size: 18), label: const Text('新购/充值'))]),
            const SizedBox(height: 8),
            StreamBuilder<List<CoursePack>>(stream: (database.select(database.coursePacks)..where((p) => p.studentId.equals(current.id))).watch(), builder: (context, snapshot) {
              final packs = snapshot.data ?? [];
              return Column(children: [
                if (packs.isEmpty) Card(color: Colors.blue.shade50, child: ListTile(leading: const Icon(Icons.monetization_on_outlined), title: const Text('随课付费配置'), subtitle: StreamBuilder<List<TypedResult>>(
                  stream: (database.select(database.studentCourseTypePrices).join([
                    innerJoin(database.courseTypes, database.courseTypes.id.equalsExp(database.studentCourseTypePrices.courseTypeId))
                  ])..where(database.studentCourseTypePrices.studentId.equals(current.id))).watch(),
                  builder: (context, priceSnap) {
                    final prices = priceSnap.data ?? [];
                    if (prices.isEmpty) return const Text('未设置分类型单价');
                    return Text('已设置 ${prices.length} 种课程单价');
                  },
                ), trailing: OutlinedButton(onPressed: () => _showEditPayPerLessonPriceDialog(context, current), child: const Text('去配置')))),
                ...packs.map((pack) {
                final progress = pack.totalLessons > 0 ? (pack.remainingLessons / pack.totalLessons) : 0.0;
                return Card(color: Colors.indigo.shade50, margin: const EdgeInsets.symmetric(vertical: 4), child: Padding(padding: const EdgeInsets.all(14.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(pack.courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('¥${pack.unitPrice}/节', style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progress.clamp(0.0, 1.0), backgroundColor: Colors.grey.shade300, color: pack.remainingLessons <= 2 ? Colors.red : Colors.indigo),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(
                      pack.remainingLessons < 0 ? '欠: ${pack.remainingLessons.abs()} 节' : '余: ${pack.remainingLessons} / 总: ${pack.totalLessons}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: pack.remainingLessons <= 2 ? Colors.red : Colors.indigo.shade900),
                    ),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                    TextButton(onPressed: current.isSuspended ? null : () => _showQuickRechargeDialog(context, pack), child: const Text('续费')),
                    TextButton(onPressed: () => _showRefundDialog(context, current, pack), style: TextButton.styleFrom(foregroundColor: Colors.red), child: const Text('退款')),
                    IconButton(icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey), onPressed: () => _confirmDeleteCoursePack(context, pack)),
                  ])]),
                ])));
              }),
            ]);
          }),
            const SizedBox(height: 20),
            const Text('历史流水', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            StreamBuilder<List<CheckInLog>>(stream: (database.select(database.checkInLogs)..where((l) => l.studentId.equals(current.id))..orderBy([(l) => OrderingTerm.desc(l.checkInTime)])).watch(), builder: (context, snapshot) {
              final logs = (snapshot.data ?? []).where((l) => l.remarks != "历史导入记录").toList();
              if (logs.isEmpty) return const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('暂无流水记录', style: TextStyle(color: Colors.grey))));
              return ListView.separated(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: logs.length, separatorBuilder: (c, i) => const Divider(), itemBuilder: (context, index) {
                final log = logs[index];
                return Slidable(
                  key: ValueKey(log.id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) async {
                          final confirm = await showDialog<bool>(context: context, builder: (c) => AlertDialog(title: const Text('撤销此记录'), content: const Text('确定要删除这笔流水并回滚课时/欠课吗？'), actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('取消')), ElevatedButton(onPressed: () => Navigator.pop(c, true), child: const Text('确定'))]));
                          if (confirm == true) {
                            await database.deleteCheckInLog(log.id);
                          }
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.undo,
                        label: '撤销',
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: log.remarks?.contains('超上') == true ? Colors.red : Colors.green,
                      child: Icon(log.remarks?.contains('超上') == true ? Icons.warning_amber_rounded : Icons.check, color: Colors.white, size: 18),
                    ),
                    title: Text(_getCheckInTitle(log)),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(DateFormat('yyyy-MM-dd HH:mm').format(log.checkInTime)),
                      if (log.remarks != null && log.remarks!.isNotEmpty) Text(log.remarks!, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                    ]),
                    trailing: Text('-${log.deductedLessons}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ),
                );
              });
            }),
          ])),
        );
      },
    );
  }

  String _getCheckInTitle(CheckInLog log) {
    if (log.remarks?.contains('超上') == true) return '欠课/超上记录';
    if (log.remarks?.contains('试课') == true) return '试课记录';
    if (log.coursePackId != null) return '课包消课 ${log.deductedLessons}节';
    return '随课付费 ¥${log.paymentAmount.toStringAsFixed(0)}';
  }

  void _showEditPayPerLessonPriceDialog(BuildContext context, Student student) async {
    final courseTypes = await database.select(database.courseTypes).get();
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('设置各课程单价 (随课付)'),
        content: SizedBox(
          width: double.maxFinite,
          child: StreamBuilder<List<StudentCourseTypePrice>>(
            stream: (database.select(database.studentCourseTypePrices)..where((p) => p.studentId.equals(student.id))).watch(),
            builder: (context, snapshot) {
              final existingPrices = snapshot.data ?? [];
              return ListView.builder(
                shrinkWrap: true,
                itemCount: courseTypes.length,
                itemBuilder: (context, index) {
                  final type = courseTypes[index];
                  final existing = existingPrices.where((p) => p.courseTypeId == type.id).toList();
                  final ctrl = TextEditingController(text: existing.isNotEmpty ? existing.first.price.toStringAsFixed(0) : '');
                  
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(type.name),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        controller: ctrl,
                        decoration: const InputDecoration(hintText: '单价', suffixText: '元'),
                        keyboardType: TextInputType.number,
                        onSubmitted: (val) async {
                          final price = double.tryParse(val);
                          if (price != null) {
                            if (existing.isNotEmpty) {
                              await (database.update(database.studentCourseTypePrices)..where((p) => p.id.equals(existing.first.id))).write(StudentCourseTypePricesCompanion(price: Value(price)));
                            } else {
                              await database.into(database.studentCourseTypePrices).insert(StudentCourseTypePricesCompanion.insert(studentId: student.id, courseTypeId: type.id, price: price));
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('关闭'))],
      ),
    );
  }

  void _confirmDeleteCoursePack(BuildContext context, CoursePack pack) {
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('确认删除'), content: const Text('确定要删除课程包吗？'), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async { await (database.delete(database.coursePacks)..where((p) => p.id.equals(pack.id))).go(); Navigator.pop(ctx); }, child: const Text('确定'))]));
  }

  void _showRefundDialog(BuildContext context, Student student, CoursePack pack) {
    final amountCtrl = TextEditingController(text: (pack.remainingLessons * pack.unitPrice).toStringAsFixed(0));
    final lessonsCtrl = TextEditingController(text: pack.remainingLessons.toString());
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('办理退款'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: lessonsCtrl, decoration: const InputDecoration(labelText: '退课时'), keyboardType: TextInputType.number), TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: '退款金额'), keyboardType: TextInputType.number)]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async { await database.executeRefund(studentId: student.id, coursePackId: pack.id, amount: double.tryParse(amountCtrl.text) ?? 0, lessons: double.tryParse(lessonsCtrl.text) ?? 0); Navigator.pop(ctx); }, child: const Text('确定'))]));
  }

  void _handleSuspend(BuildContext context, Student student) {
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('办理停课'), content: const Text('将永久删除该学员未来排课，确认吗？'), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async { await database.suspendStudent(student.id); Navigator.pop(ctx); }, child: const Text('确定'))]));
  }

  void _handleResume(BuildContext context, Student student) {
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('办理复课'), content: const Text('确认办理复课吗？'), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async { await database.resumeStudent(student.id); Navigator.pop(ctx); }, child: const Text('确定'))]));
  }

  void _confirmArchiveStudent(BuildContext context, Student student) {
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('移入回收站'), content: const Text('确认将学员移入回收站吗？'), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async { await (database.update(database.students)..where((s) => s.id.equals(student.id))).write(const StudentsCompanion(isArchived: Value(true))); Navigator.pop(ctx); Navigator.pop(context); }, child: const Text('确定'))]));
  }

  void _showEditStudentInfoDialog(BuildContext context, Student student) {
    final nameCtrl = TextEditingController(text: student.name);
    final phoneCtrl = TextEditingController(text: student.phone ?? '');
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('修改学员信息'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: '姓名', prefixIcon: Icon(Icons.person_outline))), const SizedBox(height: 12), TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: '电话', prefixIcon: Icon(Icons.phone_android_outlined)), keyboardType: TextInputType.phone)]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async {
      final name = nameCtrl.text.trim();
      if (name.isEmpty) return;
      await (database.update(database.students)..where((s) => s.id.equals(student.id))).write(StudentsCompanion(name: Value(name), phone: Value(phoneCtrl.text.trim().isEmpty ? null : phoneCtrl.text.trim())));
      if (ctx.mounted) Navigator.pop(ctx);
    }, child: const Text('保存'))]));
  }

  void _showAddOrRechargeCoursePackDialog(BuildContext context, Student current) async {
    final nameCtrl = TextEditingController(text: '常规课程');
    final totalCtrl = TextEditingController(text: '10');
    final priceCtrl = TextEditingController(text: '200');
    final courseTypes = await database.select(database.courseTypes).get();
    int? selectedTypeId = courseTypes.isNotEmpty ? courseTypes.first.id : null;

    if (!context.mounted) return;
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx) => StatefulBuilder(builder: (ctx, setS) => Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20), child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: '课程包名称')),
      DropdownButtonFormField<int?>(
        value: selectedTypeId,
        decoration: const InputDecoration(labelText: '关联课程类型'),
        items: courseTypes.map((t) => DropdownMenuItem(value: t.id, child: Text(t.name))).toList(),
        onChanged: (v) => setS(() => selectedTypeId = v),
      ),
      TextField(controller: totalCtrl, decoration: const InputDecoration(labelText: '总课时数'), keyboardType: TextInputType.number),
      TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: '单价 (元/节)'), keyboardType: TextInputType.number),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () async {
        final total = double.tryParse(totalCtrl.text) ?? 0;
        final price = double.tryParse(priceCtrl.text) ?? 0;

        double remaining = total;
        String autoRemarks = '购入新课包';

        // 检查是否有该类型的欠课需要抵扣
        if (selectedTypeId != null) {
          final debt = await (database.select(database.studentCourseTypeDebts)
                ..where((d) => d.studentId.equals(current.id) & d.courseTypeId.equals(selectedTypeId!)))
              .getSingleOrNull();
          
          if (debt != null && debt.debtAmount > 0) {
            remaining -= debt.debtAmount;
            autoRemarks += ' (自动抵扣【${courseTypes.firstWhere((t) => t.id == selectedTypeId).name}】欠课 ${debt.debtAmount} 节)';
            await (database.update(database.studentCourseTypeDebts)..where((d) => d.id.equals(debt.id))).write(const StudentCourseTypeDebtsCompanion(debtAmount: Value(0.0)));
          }
        }

        // 兼容旧全局欠课字段（如果还有的话，第一次购买任意课包时清空）
        if (current.overUsageLessons > 0) {
          await (database.update(database.students)..where((s) => s.id.equals(current.id))).write(const StudentsCompanion(overUsageLessons: Value(0.0)));
        }

        await (database.update(database.students)..where((s) => s.id.equals(current.id))).write(const StudentsCompanion(isTrial: Value(false)));
        
        final id = await database.into(database.coursePacks).insert(CoursePacksCompanion.insert(studentId: current.id, courseTypeId: Value(selectedTypeId), courseName: nameCtrl.text, totalLessons: total, remainingLessons: remaining, unitPrice: price));
        await database.into(database.purchaseLogs).insert(PurchaseLogsCompanion.insert(studentId: current.id, coursePackId: Value(id), courseName: nameCtrl.text, amount: total * price, lessons: total, remarks: Value(autoRemarks)));
        Navigator.pop(ctx);
      }, child: const Text('确定')),
      const SizedBox(height: 20)
    ]))));
  }

  void _showQuickRechargeDialog(BuildContext context, CoursePack pack) {
    final ctrl = TextEditingController(text: '10');
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('快捷续费'), content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: '追加课时'), keyboardType: TextInputType.number), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')), ElevatedButton(onPressed: () async {
      final add = double.tryParse(ctrl.text) ?? 0;
      await (database.update(database.coursePacks)..where((p) => p.id.equals(pack.id))).write(CoursePacksCompanion(totalLessons: Value(pack.totalLessons + add), remainingLessons: Value(pack.remainingLessons + add)));
      await database.into(database.purchaseLogs).insert(PurchaseLogsCompanion.insert(studentId: pack.studentId, coursePackId: Value(pack.id), courseName: pack.courseName, amount: add * pack.unitPrice, lessons: add, remarks: const Value('快捷续费')));
      Navigator.pop(ctx);
    }, child: const Text('确定'))]));
  }

  Widget _buildTinyStat(String label, String value, Color color) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withValues(alpha: 0.3))), child: Text('$label: $value', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)));
  }
}

class StatsDashboardPage extends StatelessWidget {
  const StatsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        title: const Text('数据统计'),
        bottom: const TabBar(tabs: [Tab(text: '经营看板'), Tab(text: '收支明细')], indicatorColor: Color(0xFFE89E6B), labelColor: Color(0xFFE89E6B), unselectedLabelColor: Colors.grey),
        actions: [
          IconButton(icon: const Icon(Icons.category_outlined), tooltip: '课程类型', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const CourseTypeManagementPage()))),
          IconButton(icon: const Icon(Icons.upload_file), onPressed: () async { await CsvImportService(database).importHistoryFromCsv(); })
        ]
      ),
      body: const TabBarView(children: [_StatsOverviewTab(), _FinancialDetailsTab()]),
    ));
  }
}

class CourseTypeManagementPage extends StatelessWidget {
  const CourseTypeManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课程类型管理')),
      body: StreamBuilder<List<CourseType>>(
        stream: database.select(database.courseTypes).watch(),
        builder: (context, snapshot) {
          final types = snapshot.data ?? [];
          return ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(types[index].name),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () async {
                  // 简单检查是否被引用（可选）
                  await (database.delete(database.courseTypes)..where((t) => t.id.equals(types[index].id))).go();
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTypeDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTypeDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('新增课程类型'),
      content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: '如：钢琴、美术')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
        ElevatedButton(onPressed: () async {
          if (ctrl.text.trim().isNotEmpty) {
            await database.into(database.courseTypes).insert(CourseTypesCompanion.insert(name: ctrl.text.trim()));
            if (ctx.mounted) Navigator.pop(ctx);
          }
        }, child: const Text('确定'))
      ],
    ));
  }
}

class _StatsOverviewTab extends StatelessWidget {
  const _StatsOverviewTab();
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StreamBuilder<List<CheckInLog>>(stream: database.select(database.checkInLogs).watch(), builder: (context, logSnap) {
        return StreamBuilder<List<CoursePack>>(stream: database.select(database.coursePacks).watch(), builder: (context, packSnap) {
          final logs = logSnap.data ?? [];
          final packs = packSnap.data ?? [];
          final thisMonthLogs = logs.where((l) => l.checkInTime.year == now.year && l.checkInTime.month == now.month).toList();
          double monthLessons = 0, monthValue = 0;
          for (var l in thisMonthLogs) { monthLessons += l.deductedLessons; monthValue += l.paymentAmount; }
          double totalRem = 0, totalVal = 0;
          for (var p in packs) { totalRem += p.remainingLessons; totalVal += p.remainingLessons * p.unitPrice; }
          return Column(children: [
            Padding(padding: const EdgeInsets.only(bottom: 12), child: InkWell(onTap: () async { await database.repairFinancialData(); }, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.refresh, size: 16, color: Colors.blue), SizedBox(width: 8), Text('修复历史财务数据', style: TextStyle(color: Colors.blue, fontSize: 12))])))),
            Row(children: [_buildStatCard(title: '本月课消', value: '${monthLessons.toStringAsFixed(1)}节', icon: Icons.done_all, color: const Color(0xFFE89E6B)), const SizedBox(width: 12), _buildStatCard(title: '课消价值', value: '¥${monthValue.toStringAsFixed(0)}', icon: Icons.monetization_on, color: const Color(0xFF7E9A96))]),
            const SizedBox(height: 12),
            Row(children: [_buildStatCard(title: '待消存量', value: '${totalRem.toStringAsFixed(1)}节', icon: Icons.hourglass_top, color: const Color(0xFFB5A642)), const SizedBox(width: 12), _buildStatCard(title: '存量价值', value: '¥${totalVal.toStringAsFixed(0)}', icon: Icons.account_balance_wallet, color: const Color(0xFF8B8479))]),
          ]);
        });
      }),
      const SizedBox(height: 24),
      const Text('续费预警', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
      StreamBuilder<List<TypedResult>>(
        stream: (database.select(database.coursePacks).join([
          innerJoin(database.students, database.students.id.equalsExp(database.coursePacks.studentId))
        ])..where(database.students.isArchived.equals(false) & database.coursePacks.remainingLessons.isSmallerOrEqualValue(2))).watch(),
        builder: (context, snapshot) {
          final list = snapshot.data ?? [];
          if (list.isEmpty) return const Card(child: ListTile(title: Text('暂无预警')));
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final pack = list[index].readTable(database.coursePacks);
              final student = list[index].readTable(database.students);
              return Card(
                color: Colors.red.shade50,
                child: ListTile(
                  title: Text('${student.name} · ${pack.courseName}'),
                  subtitle: Text('仅剩 ${pack.remainingLessons} 节'),
                ),
              );
            },
          );
        },
      ),
    ]));
  }
}

class _FinancialDetailsTab extends StatelessWidget {
  const _FinancialDetailsTab();
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StreamBuilder<List<PurchaseLog>>(stream: database.select(database.purchaseLogs).watch(), builder: (context, pSnap) {
        return StreamBuilder<List<CheckInLog>>(stream: (database.select(database.checkInLogs)..where((l) => l.coursePackId.isNull())).watch(), builder: (context, paySnap) {
          final pList = (pSnap.data ?? []).where((p) => p.purchaseTime.year == now.year && p.purchaseTime.month == now.month).toList();
          // 仅过滤真正的“随课付费”，排除“超上”和“试课”产生的欠费记录
          final payList = (paySnap.data ?? []).where((l) => 
            l.checkInTime.year == now.year && 
            l.checkInTime.month == now.month &&
            l.remarks?.contains('超上') != true &&
            l.remarks?.contains('试课') != true
          ).toList();
          double pSum = 0, paySum = 0;
          for (var p in pList) pSum += p.amount;
          for (var l in payList) paySum += l.paymentAmount;
          return Column(children: [
            Container(width: double.infinity, padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFE89E6B), Color(0xFFD48B8B)]), borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('本月实收现金总计', style: TextStyle(color: Colors.white, fontSize: 13)),
              Text('¥${(pSum + paySum).toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('充值收入', style: TextStyle(color: Colors.white70, fontSize: 11)), Text('¥${pSum.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                const SizedBox(width: 24),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('随课收入', style: TextStyle(color: Colors.white70, fontSize: 11)), Text('¥${paySum.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
              ]),
            ])),
          ]);
        });
      }),
      const SizedBox(height: 24),
      const Text('收入明细', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      StreamBuilder<List<TypedResult>>(
        stream: (database.select(database.purchaseLogs).join([
          innerJoin(database.students, database.students.id.equalsExp(database.purchaseLogs.studentId))
        ])..orderBy([OrderingTerm.desc(database.purchaseLogs.purchaseTime)])).watch(),
        builder: (context, snapshot) {
          final list = snapshot.data ?? [];
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final log = list[index].readTable(database.purchaseLogs);
              final student = list[index].readTable(database.students);
              return ListTile(
                title: Text('${student.name} · ${log.courseName}'),
                subtitle: Text(DateFormat('MM-dd').format(log.purchaseTime)),
                trailing: Text('+¥${log.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              );
            },
          );
        },
      ),
    ]));
  }
}

Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
  return Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 18, color: color)),
    const SizedBox(height: 16),
    Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFFBAB3A9))),
    Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A453E))),
  ])));
}

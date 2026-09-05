import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'app_database.g.dart';

enum ScheduleStatus {
  scheduled,    // 待上课
  completed,    // 已消课
  studentLeave, // 学员请假
}

class CourseTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isSuspended => boolean().withDefault(const Constant(false))();
  RealColumn get initialAccumulatedLessons => real().withDefault(const Constant(0.0))();
  RealColumn get payPerLessonPrice => real().nullable()(); // 旧全局字段，保留做兼容
  BoolColumn get isTrial => boolean().withDefault(const Constant(false))();
  RealColumn get overUsageLessons => real().withDefault(const Constant(0.0))(); // 全局旧数据字段，保留做兼容
}

class StudentCourseTypePrices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get courseTypeId => integer().references(CourseTypes, #id)();
  RealColumn get price => real()();
}

class StudentCourseTypeDebts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get courseTypeId => integer().references(CourseTypes, #id)();
  RealColumn get debtAmount => real().withDefault(const Constant(0.0))();
}

class CoursePacks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get courseTypeId => integer().references(CourseTypes, #id).nullable()();
  TextColumn get courseName => text().withLength(min: 1, max: 50)();
  RealColumn get totalLessons => real()();
  RealColumn get remainingLessons => real()();
  RealColumn get unitPrice => real()();
  RealColumn get initialAccumulatedLessons => real().withDefault(const Constant(0.0))();
}

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get coursePackId => integer().references(CoursePacks, #id).nullable()();
  IntColumn get courseTypeId => integer().references(CourseTypes, #id).nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  RealColumn get lessonDeduction => real().withDefault(const Constant(1.0))();
  IntColumn get status => intEnum<ScheduleStatus>().withDefault(Constant(ScheduleStatus.scheduled.index))();
  TextColumn get systemEventId => text().nullable()();
  TextColumn get recurringGroupId => text().nullable()();
}

class CheckInLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scheduleId => integer().references(Schedules, #id).nullable()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get coursePackId => integer().references(CoursePacks, #id).nullable()();
  IntColumn get courseTypeId => integer().references(CourseTypes, #id).nullable()();
  RealColumn get deductedLessons => real()();
  DateTimeColumn get checkInTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get remarks => text().nullable()();
  RealColumn get paymentAmount => real().withDefault(const Constant(0.0))();
}

class RefundLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get coursePackId => integer().references(CoursePacks, #id)();
  RealColumn get refundAmount => real()();
  RealColumn get deductedLessons => real()();
  DateTimeColumn get refundTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get remarks => text().nullable()();
}

class PurchaseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get coursePackId => integer().references(CoursePacks, #id).nullable()();
  TextColumn get courseName => text()(); // 记录当时的课程名
  RealColumn get amount => real()(); // 支付金额
  RealColumn get lessons => real()(); // 购买/充值课时
  DateTimeColumn get purchaseTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get remarks => text().nullable()();
}

@DriftDatabase(tables: [Students, CoursePacks, Schedules, CheckInLogs, RefundLogs, PurchaseLogs, CourseTypes, StudentCourseTypeDebts, StudentCourseTypePrices])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 16;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'edu_manager_db');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) await m.addColumn(students, students.isArchived);
      if (from < 3) await m.addColumn(students, students.isSuspended);
      if (from < 4) await m.createTable(refundLogs);
      if (from < 6) {
        await m.alterTable(TableMigration(checkInLogs));
        try { await m.addColumn(schedules, schedules.systemEventId); } catch (_) {}
      }
      if (from < 7) {
        try { await m.addColumn(coursePacks, coursePacks.initialAccumulatedLessons); } catch (_) {}
      }
      if (from < 8) {
        await m.addColumn(students, students.initialAccumulatedLessons);
      }
      if (from < 9) {
        await m.alterTable(TableMigration(schedules));
        await m.alterTable(TableMigration(checkInLogs));
      }
      if (from < 10) {
        await m.addColumn(this.students, this.students.payPerLessonPrice);
        await m.addColumn(this.checkInLogs, this.checkInLogs.paymentAmount);
      }
      if (from < 11) {
        await m.createTable(purchaseLogs);
      }
      if (from < 12) {
        await m.addColumn(students, students.isTrial);
      }
      if (from < 13) {
        await m.addColumn(students, students.overUsageLessons);
      }
      if (from < 14) {
        await m.createTable(courseTypes);
        await m.createTable(studentCourseTypeDebts);
        await m.addColumn(coursePacks, coursePacks.courseTypeId);
        await m.addColumn(schedules, schedules.courseTypeId);
        await m.addColumn(checkInLogs, checkInLogs.courseTypeId);
        
        // 预设一些常用的课程类型
        await batch((batch) {
          batch.insertAll(courseTypes, [
            CourseTypesCompanion.insert(name: '钢琴'),
            CourseTypesCompanion.insert(name: '美术'),
            CourseTypesCompanion.insert(name: '乐理'),
            CourseTypesCompanion.insert(name: '吉他'),
          ]);
        });
      }
      if (from < 15) {
        await m.addColumn(schedules, schedules.recurringGroupId);
      }
      if (from < 16) {
        await m.createTable(studentCourseTypePrices);
      }
    },
  );

  Future<int> suspendStudent(int studentId) async {
    return transaction(() async {
      await (update(students)..where((s) => s.id.equals(studentId))).write(
        const StudentsCompanion(isSuspended: Value(true)),
      );
      final allFutureSchedules = await (select(schedules)
        ..where((s) =>
        s.studentId.equals(studentId) &
        s.status.equals(ScheduleStatus.scheduled.index)))
          .get();

      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      final toDelete = allFutureSchedules.where((s) => !s.startTime.isBefore(startOfToday)).toList();

      final count = toDelete.length;
      if (count > 0) {
        final ids = toDelete.map((s) => s.id).toList();
        await (delete(schedules)..where((s) => s.id.isIn(ids))).go();
      }
      return count;
    });
  }

  Future<void> resumeStudent(int studentId) async {
    await (update(students)..where((s) => s.id.equals(studentId))).write(
      const StudentsCompanion(isSuspended: Value(false)),
    );
  }

  Future<void> executeCheckIn({
    required int scheduleId,
    String? remarks,
  }) async {
    return transaction(() async {
      final schedule = await (select(schedules)..where((s) => s.id.equals(scheduleId))).getSingleOrNull();
      if (schedule == null) throw Exception("排课不存在");
      if (schedule.status == ScheduleStatus.completed) throw Exception("该日程已消课");

      double paymentAmount = 0.0;
      String finalRemarks = remarks ?? "";
      final student = await (select(students)..where((s) => s.id.equals(schedule.studentId))).getSingle();

      int? effectiveCourseTypeId = schedule.courseTypeId;

      if (schedule.coursePackId != null) {
        final pack = await (select(coursePacks)..where((p) => p.id.equals(schedule.coursePackId!))).getSingleOrNull();
        if (pack == null) throw Exception("课时包不存在");
        
        effectiveCourseTypeId = pack.courseTypeId;
        String typeName = "未知";
        if (effectiveCourseTypeId != null) {
          final ct = await (select(courseTypes)..where((t) => t.id.equals(effectiveCourseTypeId!))).getSingleOrNull();
          if (ct != null) typeName = ct.name;
        }

        // 记录超上 (有课包模式)
        if (pack.remainingLessons < schedule.lessonDeduction) {
          final debtAmount = schedule.lessonDeduction - (pack.remainingLessons > 0 ? pack.remainingLessons : 0);
          finalRemarks = "【$typeName】超上 $finalRemarks";
          
          if (effectiveCourseTypeId != null) {
            await _recordDebt(student.id, effectiveCourseTypeId, debtAmount);
          }
        }

        final updatedRemaining = pack.remainingLessons - schedule.lessonDeduction;
        await (update(coursePacks)..where((p) => p.id.equals(pack.id))).write(
          CoursePacksCompanion(remainingLessons: Value(updatedRemaining)),
        );
        
        paymentAmount = schedule.lessonDeduction * pack.unitPrice;
      } else {
        // 无课包模式
        String typeName = "未知";
        if (effectiveCourseTypeId != null) {
          final ct = await (select(courseTypes)..where((t) => t.id.equals(effectiveCourseTypeId!))).getSingleOrNull();
          if (ct != null) typeName = ct.name;
        }

        if (effectiveCourseTypeId != null) {
          finalRemarks = (student.isTrial) ? "【$typeName】试课 $finalRemarks" : "【$typeName】超上 $finalRemarks";
          await _recordDebt(student.id, effectiveCourseTypeId!, schedule.lessonDeduction);
          
          // 获取该课程类型的随课单价
          final typePrice = await (select(studentCourseTypePrices)
                ..where((p) => p.studentId.equals(student.id) & p.courseTypeId.equals(effectiveCourseTypeId!)))
              .getSingleOrNull();
          
          if (typePrice != null) {
            paymentAmount = schedule.lessonDeduction * typePrice.price;
          } else if (student.payPerLessonPrice != null) {
            // 兼容旧全局单价
            paymentAmount = schedule.lessonDeduction * student.payPerLessonPrice!;
          }
        }
      }

      await (update(schedules)..where((s) => s.id.equals(scheduleId))).write(
        const SchedulesCompanion(status: Value(ScheduleStatus.completed)),
      );

      await into(checkInLogs).insert(
        CheckInLogsCompanion.insert(
          scheduleId: Value(scheduleId),
          studentId: schedule.studentId,
          coursePackId: Value(schedule.coursePackId),
          courseTypeId: Value(effectiveCourseTypeId),
          deductedLessons: schedule.lessonDeduction,
          remarks: Value(finalRemarks),
          paymentAmount: Value(paymentAmount),
        ),
      );
    });
  }

  Future<void> _recordDebt(int studentId, int courseTypeId, double amount) async {
    final existingDebt = await (select(studentCourseTypeDebts)
          ..where((d) => d.studentId.equals(studentId) & d.courseTypeId.equals(courseTypeId)))
        .getSingleOrNull();

    if (existingDebt != null) {
      await (update(studentCourseTypeDebts)..where((d) => d.id.equals(existingDebt.id))).write(
        StudentCourseTypeDebtsCompanion(debtAmount: Value(existingDebt.debtAmount + amount)),
      );
    } else {
      await into(studentCourseTypeDebts).insert(
        StudentCourseTypeDebtsCompanion.insert(
          studentId: studentId,
          courseTypeId: courseTypeId,
          debtAmount: Value(amount),
        ),
      );
    }
  }

  Future<void> markStudentLeave(int scheduleId) async {
    await (update(schedules)..where((s) => s.id.equals(scheduleId))).write(
      const SchedulesCompanion(status: Value(ScheduleStatus.scheduled)), // 修正：应先设为 scheduled 的逻辑处理
    );
    // 实际应为：
    await (update(schedules)..where((s) => s.id.equals(scheduleId))).write(
      const SchedulesCompanion(status: Value(ScheduleStatus.studentLeave)),
    );
  }

  /// 撤销排课状态（还原为待上课）
  Future<void> revertScheduleStatus(int scheduleId) async {
    return transaction(() async {
      final schedule = await (select(schedules)..where((s) => s.id.equals(scheduleId))).getSingleOrNull();
      if (schedule == null) return;
      if (schedule.status == ScheduleStatus.scheduled) return;

      // 如果之前是已消课状态，需要处理课时退回
      if (schedule.status == ScheduleStatus.completed) {
        final log = await (select(checkInLogs)..where((l) => l.scheduleId.equals(scheduleId))).getSingleOrNull();
        if (log != null) {
          // 1. 如果有课时包，退回课时
          if (log.coursePackId != null) {
            final pack = await (select(coursePacks)..where((p) => p.id.equals(log.coursePackId!))).getSingleOrNull();
            if (pack != null) {
              final oldRem = pack.remainingLessons;
              final newRem = oldRem + log.deductedLessons;
              
              // 2. 如果之前是负数（欠课），需要修复学员表的累计欠课数
              if (oldRem < 0) {
                final effectiveCourseTypeId = log.courseTypeId;
                if (effectiveCourseTypeId != null) {
                  final existingDebt = await (select(studentCourseTypeDebts)
                        ..where((d) => d.studentId.equals(log.studentId) & d.courseTypeId.equals(effectiveCourseTypeId)))
                      .getSingleOrNull();

                  if (existingDebt != null) {
                    final reclaimedDebt = (log.deductedLessons < existingDebt.debtAmount) ? log.deductedLessons : existingDebt.debtAmount;
                    await (update(studentCourseTypeDebts)..where((d) => d.id.equals(existingDebt.id))).write(
                      StudentCourseTypeDebtsCompanion(debtAmount: Value((existingDebt.debtAmount - reclaimedDebt).clamp(0, 9999))),
                    );
                  }
                }
              }

              await (update(coursePacks)..where((p) => p.id.equals(pack.id))).write(
                CoursePacksCompanion(remainingLessons: Value(newRem)),
              );
            }
          } else {
            // 无课包模式的撤销
            final effectiveCourseTypeId = log.courseTypeId;
            if (effectiveCourseTypeId != null) {
              final existingDebt = await (select(studentCourseTypeDebts)
                    ..where((d) => d.studentId.equals(log.studentId) & d.courseTypeId.equals(effectiveCourseTypeId)))
                  .getSingleOrNull();

              if (existingDebt != null) {
                await (update(studentCourseTypeDebts)..where((d) => d.id.equals(existingDebt.id))).write(
                  StudentCourseTypeDebtsCompanion(debtAmount: Value((existingDebt.debtAmount - log.deductedLessons).clamp(0, 9999))),
                );
              }
            }
          }
          // 3. 删除消课记录
          await (delete(checkInLogs)..where((l) => l.id.equals(log.id))).go();
        }
      }

      // 最后将状态设回待上课
      await (update(schedules)..where((s) => s.id.equals(scheduleId))).write(
        const SchedulesCompanion(status: Value(ScheduleStatus.scheduled)),
      );
    });
  }

  /// 直接删除消课流水（用于处理历史错误数据，同时自动回滚课时/欠课）
  Future<void> deleteCheckInLog(int logId) async {
    return transaction(() async {
      final log = await (select(checkInLogs)..where((l) => l.id.equals(logId))).getSingleOrNull();
      if (log == null) return;

      // 1. 回滚课时包余额
      if (log.coursePackId != null) {
        final pack = await (select(coursePacks)..where((p) => p.id.equals(log.coursePackId!))).getSingleOrNull();
        if (pack != null) {
          final oldRem = pack.remainingLessons;
          final newRem = oldRem + log.deductedLessons;

          // 2. 如果之前是欠课状态，修复欠课数
          if (oldRem < 0) {
            final typeId = log.courseTypeId;
            if (typeId != null) {
              final debt = await (select(studentCourseTypeDebts)
                    ..where((d) => d.studentId.equals(log.studentId) & d.courseTypeId.equals(typeId)))
                  .getSingleOrNull();
              if (debt != null) {
                final reclaimed = (log.deductedLessons < debt.debtAmount) ? log.deductedLessons : debt.debtAmount;
                await (update(studentCourseTypeDebts)..where((d) => d.id.equals(debt.id))).write(
                  StudentCourseTypeDebtsCompanion(debtAmount: Value((debt.debtAmount - reclaimed).clamp(0, 9999))),
                );
              }
            }
          }
          await (update(coursePacks)..where((p) => p.id.equals(pack.id))).write(
            CoursePacksCompanion(remainingLessons: Value(newRem)),
          );
        }
      } else {
        // 无课包模式的回滚
        final typeId = log.courseTypeId;
        if (typeId != null) {
          final debt = await (select(studentCourseTypeDebts)
                ..where((d) => d.studentId.equals(log.studentId) & d.courseTypeId.equals(typeId)))
              .getSingleOrNull();
          if (debt != null) {
            await (update(studentCourseTypeDebts)..where((d) => d.id.equals(debt.id))).write(
              StudentCourseTypeDebtsCompanion(debtAmount: Value((debt.debtAmount - log.deductedLessons).clamp(0, 9999))),
            );
          }
        }
      }

      // 3. 如果关联了排课，将排课状态还原
      if (log.scheduleId != null) {
        await (update(schedules)..where((s) => s.id.equals(log.scheduleId!))).write(
          const SchedulesCompanion(status: Value(ScheduleStatus.scheduled)),
        );
      }

      // 4. 删除流水
      await (delete(checkInLogs)..where((l) => l.id.equals(logId))).go();
    });
  }

  /// 安全删除排课（智能识别循环系列）
  Future<void> deleteSchedule(int scheduleId, {bool onlyThis = true}) async {
    return transaction(() async {
      final schedule = await (select(schedules)..where((s) => s.id.equals(scheduleId))).getSingleOrNull();
      if (schedule == null) return;

      if (onlyThis) {
        if (schedule.status != ScheduleStatus.scheduled) await revertScheduleStatus(scheduleId);
        await (delete(schedules)..where((s) => s.id.equals(scheduleId))).go();
      } else {
        // 批量删除逻辑
        List<Schedule> toDeleteSeries = [];
        
        if (schedule.recurringGroupId != null) {
          // 1. 如果有新版分组ID，按组删除
          toDeleteSeries = await (select(schedules)
            ..where((s) => s.recurringGroupId.equals(schedule.recurringGroupId!) & s.startTime.isBiggerOrEqualValue(schedule.startTime)))
            .get();
        } else {
          // 2. 针对旧数据的智能回溯：匹配【同一学员 + 同一类型 + 同一星期几】
          toDeleteSeries = await (select(schedules)
            ..where((s) {
              var predicate = s.studentId.equals(schedule.studentId) & 
                              s.startTime.isBiggerOrEqualValue(schedule.startTime);
              
              if (schedule.courseTypeId != null) {
                predicate = predicate & s.courseTypeId.equals(schedule.courseTypeId!);
              } else {
                predicate = predicate & s.courseTypeId.isNull();
              }
              return predicate;
            }))
            .get();
          
          // 进一步过滤出星期几一致的（比如都是周一）
          toDeleteSeries = toDeleteSeries.where((s) => s.startTime.weekday == schedule.startTime.weekday).toList();
        }
        
        // 确保即使搜索逻辑有问题，当前的这节课也一定会被加入待删除列表
        if (!toDeleteSeries.any((s) => s.id == scheduleId)) {
          toDeleteSeries.add(schedule);
        }

        for (var s in toDeleteSeries) {
          if (s.status != ScheduleStatus.scheduled) await revertScheduleStatus(s.id);
          await (delete(schedules)..where((item) => item.id.equals(s.id))).go();
        }
      }
    });
  }

  Future<void> executeRefund({
    required int studentId,
    required int coursePackId,
    required double amount,
    required double lessons,
    String? remarks,
  }) async {
    return transaction(() async {
      final pack = await (select(coursePacks)..where((p) => p.id.equals(coursePackId))).getSingleOrNull();
      if (pack == null) throw Exception("课时包不存在");
      if (pack.remainingLessons < lessons) {
        throw Exception("剩余课时不足以退款！剩余: ${pack.remainingLessons} 节");
      }

      final updatedRemaining = pack.remainingLessons - lessons;
      await (update(coursePacks)..where((p) => p.id.equals(pack.id))).write(
        CoursePacksCompanion(remainingLessons: Value(updatedRemaining)),
      );

      await into(refundLogs).insert(
        RefundLogsCompanion.insert(
          studentId: studentId,
          coursePackId: coursePackId,
          refundAmount: amount,
          deductedLessons: lessons,
          refundTime: Value(DateTime.now()),
          remarks: Value(remarks),
        ),
      );
    });
  }

  Future<bool> hasScheduleConflict(DateTime start, DateTime end, {int? excludeId}) async {
    final conflicts = await (select(schedules)
      ..where((s) {
        var predicate = s.startTime.isSmallerThanValue(end) & s.endTime.isBiggerThanValue(start);
        if (excludeId != null) {
          predicate = predicate & s.id.equals(excludeId).not();
        }
        return predicate;
      }))
        .get();
    return conflicts.isNotEmpty;
  }

  Future<void> updateScheduleTime(int scheduleId, DateTime start, DateTime end) async {
    if (await hasScheduleConflict(start, end, excludeId: scheduleId)) {
      throw Exception("该时段已有其他课程冲突");
    }

    await (update(schedules)..where((s) => s.id.equals(scheduleId))).write(
      SchedulesCompanion(
        startTime: Value(start),
        endTime: Value(end),
      ),
    );
  }

  // 财务数据修复与初始化
  Future<void> repairFinancialData() async {
    return transaction(() async {
      // 1. 修复 CheckInLogs 的 paymentAmount
      final allLogs = await select(checkInLogs).get();
      for (var log in allLogs) {
        if (log.paymentAmount == 0) {
          double price = 0;
          if (log.coursePackId != null) {
            final pack = await (select(coursePacks)..where((p) => p.id.equals(log.coursePackId!))).getSingleOrNull();
            price = pack?.unitPrice ?? 0;
          } else {
            final student = await (select(students)..where((s) => s.id.equals(log.studentId))).getSingleOrNull();
            price = student?.payPerLessonPrice ?? 0;
          }
          if (price > 0) {
            await (update(checkInLogs)..where((l) => l.id.equals(log.id))).write(
              CheckInLogsCompanion(paymentAmount: Value(log.deductedLessons * price))
            );
          }
        }
      }

      // 2. 为现有课程包生成初始化购买记录 (如果还没有的话)
      final allPacks = await select(coursePacks).get();
      for (var pack in allPacks) {
        final existing = await (select(purchaseLogs)..where((p) => p.coursePackId.equals(pack.id))).get();
        if (existing.isEmpty) {
          await into(purchaseLogs).insert(
            PurchaseLogsCompanion.insert(
              studentId: pack.studentId,
              coursePackId: Value(pack.id),
              courseName: pack.courseName,
              amount: pack.totalLessons * pack.unitPrice,
              lessons: pack.totalLessons,
              remarks: const Value('系统初始化导入'),
            )
          );
        }
      }
    });
  }
}

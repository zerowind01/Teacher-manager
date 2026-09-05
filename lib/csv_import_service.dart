import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'app_database.dart';

class ImportResult {
  final int success;
  final int failed;
  final int skipped;
  final String? firstError;
  final List<String> rawDataSample;

  ImportResult({
    required this.success, 
    required this.failed, 
    this.skipped = 0,
    this.firstError, 
    this.rawDataSample = const []
  });
}

class CsvImportService {
  final AppDatabase db;
  CsvImportService(this.db);

  Future<ImportResult> importHistoryFromCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null || result.files.single.path == null) {
      return ImportResult(success: 0, failed: 0);
    }

    try {
      final content = await File(result.files.single.path!).readAsBytes();
      String decoded;
      try {
        decoded = utf8.decode(content);
      } catch (e) {
        decoded = utf8.decode(content, allowMalformed: true);
      }

      int commaCount = ','.allMatches(decoded.split('\n').first).length;
      int tabCount = '\t'.allMatches(decoded.split('\n').first).length;
      String delimiter = commaCount >= tabCount ? ',' : '\t';

      var fields = CsvToListConverter(fieldDelimiter: delimiter).convert(decoded);
      if (fields.isEmpty) return ImportResult(success: 0, failed: 0, firstError: "无法解析文件内容");

      int successCount = 0;
      int failedCount = 0;

      int nameIdx = 1;
      int accumulatedIdx = 4;
      int joinedDateIdx = 16;

      final header = fields[0].map((e) => e.toString().trim()).toList();
      for (int i = 0; i < header.length; i++) {
        String h = header[i];
        if (h.contains('姓名')) nameIdx = i;
        if (h.contains('累计上课')) accumulatedIdx = i;
        if (h.contains('入营') || h.contains('启用')) joinedDateIdx = i;
      }

      for (int i = 1; i < fields.length; i++) {
        final row = fields[i];
        if (row.length <= nameIdx) continue;

        try {
          final studentName = row[nameIdx].toString().trim();
          if (studentName.isEmpty || studentName == '学员姓名') continue;

          final csvAccumulated = double.tryParse(row[accumulatedIdx].toString()) ?? 0.0;
          final joinedDateStr = row[joinedDateIdx].toString().trim();

          DateTime joinedDate = DateTime.now();
          if (joinedDateStr.isNotEmpty) {
            try {
              joinedDate = DateTime.parse(joinedDateStr.replaceAll(' ', 'T'));
            } catch (_) {}
          }

          await db.transaction(() async {
            // 仅处理学员数据，不处理课程包
            var student = await (db.select(db.students)..where((s) => s.name.equals(studentName))).getSingleOrNull();
            
            if (student == null) {
              await db.into(db.students).insert(StudentsCompanion.insert(
                name: studentName, 
                createdAt: Value(joinedDate),
                initialAccumulatedLessons: Value(csvAccumulated),
              ));
            } else {
              // 更新现有学员的累计值和加入时间
              await (db.update(db.students)..where((s) => s.id.equals(student.id))).write(
                StudentsCompanion(
                  createdAt: Value(joinedDate),
                  initialAccumulatedLessons: Value(csvAccumulated),
                )
              );
            }
          });
          successCount++;
        } catch (e) {
          failedCount++;
        }
      }

      return ImportResult(success: successCount, failed: failedCount, rawDataSample: fields.take(3).map((e) => e.toString()).toList());
    } catch (e) {
      return ImportResult(success: 0, failed: 0, firstError: "错误: $e");
    }
  }
}

import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor connect(String name) {
  return WebDatabase(name);
}

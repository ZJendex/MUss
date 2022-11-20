import 'package:drift/drift.dart';

class Task extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get course => integer().nullable()();
  TextColumn get description => text()();
}

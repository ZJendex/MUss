import 'package:drift/drift.dart';

class Course extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named("course_name")();
}

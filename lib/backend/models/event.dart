import 'package:drift/drift.dart';

class Event extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get course => integer().nullable()();
  IntColumn get task => integer().nullable()();
  IntColumn get duration => integer().nullable()();
  DateTimeColumn get from => dateTime()();
  DateTimeColumn get to => dateTime().nullable()();
}

import 'package:drift/drift.dart';

class RunnignEvent extends Table {
  IntColumn get id => integer()();
  IntColumn get event => integer().nullable()();
}

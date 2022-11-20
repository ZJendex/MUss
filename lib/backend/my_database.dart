import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:muss/backend/models/running_event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'models/course.dart';
import 'models/event.dart';
import 'models/task.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'my_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Event, Course, Task, RunnignEvent])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  // Event Operators
  Future<List<EventData>> getEvents() async {
    return await select(event).get();
  }

  Future<EventData> getEvent(int id) async {
    return await (select(event)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateEvent(EventCompanion entity) async {
    return await update(event).replace(entity);
  }

  Future<int> insertEvent(EventCompanion entity) async {
    return await into(event).insert(entity);
  }

  Future<int> deleteEvent(int id) async {
    return await (delete(event)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteALLEvent() async {
    return await delete(event).go();
  }

  // Course Operators
  Future<List<CourseData>> getCourses() async {
    return await select(course).get();
  }

  Future<CourseData?> getCourse(int id) async {
    return await (select(course)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<CourseData?> getCourseByName(String s) async {
    return await (select(course)..where((tbl) => tbl.name.equals(s)))
        .getSingleOrNull();
  }

  Future<bool> updateCourse(CourseCompanion entity) async {
    return await update(course).replace(entity);
  }

  Future<int> insertCourse(CourseCompanion entity) async {
    return await into(course).insert(entity);
  }

  Future<int> deleteCourse(int id) async {
    return await (delete(course)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteALLCourse() async {
    return await delete(course).go();
  }

  // Task Operators
  Future<List<TaskData>> getTasks() async {
    return await select(task).get();
  }

  Future<TaskData> getTask(int id) async {
    return await (select(task)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateTask(TaskCompanion entity) async {
    return await update(task).replace(entity);
  }

  Future<int> insertTask(TaskCompanion entity) async {
    return await into(task).insert(entity);
  }

  Future<int> deleteTask(int id) async {
    return await (delete(task)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteALLTask() async {
    return await delete(task).go();
  }
}

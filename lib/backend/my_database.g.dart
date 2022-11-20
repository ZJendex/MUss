// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class EventData extends DataClass implements Insertable<EventData> {
  final int id;
  final int? course;
  final int? task;
  final int? duration;
  final DateTime from;
  final DateTime? to;
  const EventData(
      {required this.id,
      this.course,
      this.task,
      this.duration,
      required this.from,
      this.to});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || course != null) {
      map['course'] = Variable<int>(course);
    }
    if (!nullToAbsent || task != null) {
      map['task'] = Variable<int>(task);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    map['from'] = Variable<DateTime>(from);
    if (!nullToAbsent || to != null) {
      map['to'] = Variable<DateTime>(to);
    }
    return map;
  }

  EventCompanion toCompanion(bool nullToAbsent) {
    return EventCompanion(
      id: Value(id),
      course:
          course == null && nullToAbsent ? const Value.absent() : Value(course),
      task: task == null && nullToAbsent ? const Value.absent() : Value(task),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      from: Value(from),
      to: to == null && nullToAbsent ? const Value.absent() : Value(to),
    );
  }

  factory EventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventData(
      id: serializer.fromJson<int>(json['id']),
      course: serializer.fromJson<int?>(json['course']),
      task: serializer.fromJson<int?>(json['task']),
      duration: serializer.fromJson<int?>(json['duration']),
      from: serializer.fromJson<DateTime>(json['from']),
      to: serializer.fromJson<DateTime?>(json['to']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'course': serializer.toJson<int?>(course),
      'task': serializer.toJson<int?>(task),
      'duration': serializer.toJson<int?>(duration),
      'from': serializer.toJson<DateTime>(from),
      'to': serializer.toJson<DateTime?>(to),
    };
  }

  EventData copyWith(
          {int? id,
          Value<int?> course = const Value.absent(),
          Value<int?> task = const Value.absent(),
          Value<int?> duration = const Value.absent(),
          DateTime? from,
          Value<DateTime?> to = const Value.absent()}) =>
      EventData(
        id: id ?? this.id,
        course: course.present ? course.value : this.course,
        task: task.present ? task.value : this.task,
        duration: duration.present ? duration.value : this.duration,
        from: from ?? this.from,
        to: to.present ? to.value : this.to,
      );
  @override
  String toString() {
    return (StringBuffer('EventData(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('task: $task, ')
          ..write('duration: $duration, ')
          ..write('from: $from, ')
          ..write('to: $to')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, course, task, duration, from, to);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventData &&
          other.id == this.id &&
          other.course == this.course &&
          other.task == this.task &&
          other.duration == this.duration &&
          other.from == this.from &&
          other.to == this.to);
}

class EventCompanion extends UpdateCompanion<EventData> {
  final Value<int> id;
  final Value<int?> course;
  final Value<int?> task;
  final Value<int?> duration;
  final Value<DateTime> from;
  final Value<DateTime?> to;
  const EventCompanion({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    this.task = const Value.absent(),
    this.duration = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
  });
  EventCompanion.insert({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    this.task = const Value.absent(),
    this.duration = const Value.absent(),
    required DateTime from,
    this.to = const Value.absent(),
  }) : from = Value(from);
  static Insertable<EventData> custom({
    Expression<int>? id,
    Expression<int>? course,
    Expression<int>? task,
    Expression<int>? duration,
    Expression<DateTime>? from,
    Expression<DateTime>? to,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (course != null) 'course': course,
      if (task != null) 'task': task,
      if (duration != null) 'duration': duration,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    });
  }

  EventCompanion copyWith(
      {Value<int>? id,
      Value<int?>? course,
      Value<int?>? task,
      Value<int?>? duration,
      Value<DateTime>? from,
      Value<DateTime?>? to}) {
    return EventCompanion(
      id: id ?? this.id,
      course: course ?? this.course,
      task: task ?? this.task,
      duration: duration ?? this.duration,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (course.present) {
      map['course'] = Variable<int>(course.value);
    }
    if (task.present) {
      map['task'] = Variable<int>(task.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (from.present) {
      map['from'] = Variable<DateTime>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<DateTime>(to.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventCompanion(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('task: $task, ')
          ..write('duration: $duration, ')
          ..write('from: $from, ')
          ..write('to: $to')
          ..write(')'))
        .toString();
  }
}

class $EventTable extends Event with TableInfo<$EventTable, EventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _courseMeta = const VerificationMeta('course');
  @override
  late final GeneratedColumn<int> course = GeneratedColumn<int>(
      'course', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _taskMeta = const VerificationMeta('task');
  @override
  late final GeneratedColumn<int> task = GeneratedColumn<int>(
      'task', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<DateTime> from = GeneratedColumn<DateTime>(
      'from', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _toMeta = const VerificationMeta('to');
  @override
  late final GeneratedColumn<DateTime> to = GeneratedColumn<DateTime>(
      'to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, course, task, duration, from, to];
  @override
  String get aliasedName => _alias ?? 'event';
  @override
  String get actualTableName => 'event';
  @override
  VerificationContext validateIntegrity(Insertable<EventData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course')) {
      context.handle(_courseMeta,
          course.isAcceptableOrUnknown(data['course']!, _courseMeta));
    }
    if (data.containsKey('task')) {
      context.handle(
          _taskMeta, task.isAcceptableOrUnknown(data['task']!, _taskMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('from')) {
      context.handle(
          _fromMeta, from.isAcceptableOrUnknown(data['from']!, _fromMeta));
    } else if (isInserting) {
      context.missing(_fromMeta);
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to']!, _toMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      course: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}course']),
      task: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}task']),
      duration: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
      from: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}from'])!,
      to: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}to']),
    );
  }

  @override
  $EventTable createAlias(String alias) {
    return $EventTable(attachedDatabase, alias);
  }
}

class CourseData extends DataClass implements Insertable<CourseData> {
  final int id;
  final String name;
  const CourseData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['course_name'] = Variable<String>(name);
    return map;
  }

  CourseCompanion toCompanion(bool nullToAbsent) {
    return CourseCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory CourseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  CourseData copyWith({int? id, String? name}) => CourseData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('CourseData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseData && other.id == this.id && other.name == this.name);
}

class CourseCompanion extends UpdateCompanion<CourseData> {
  final Value<int> id;
  final Value<String> name;
  const CourseCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CourseCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<CourseData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'course_name': name,
    });
  }

  CourseCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CourseCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['course_name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CourseTable extends Course with TableInfo<$CourseTable, CourseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'course_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'course';
  @override
  String get actualTableName => 'course';
  @override
  VerificationContext validateIntegrity(Insertable<CourseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course_name')) {
      context.handle(_nameMeta,
          name.isAcceptableOrUnknown(data['course_name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}course_name'])!,
    );
  }

  @override
  $CourseTable createAlias(String alias) {
    return $CourseTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final int? course;
  final String description;
  const TaskData({required this.id, this.course, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || course != null) {
      map['course'] = Variable<int>(course);
    }
    map['description'] = Variable<String>(description);
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      course:
          course == null && nullToAbsent ? const Value.absent() : Value(course),
      description: Value(description),
    );
  }

  factory TaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      course: serializer.fromJson<int?>(json['course']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'course': serializer.toJson<int?>(course),
      'description': serializer.toJson<String>(description),
    };
  }

  TaskData copyWith(
          {int? id,
          Value<int?> course = const Value.absent(),
          String? description}) =>
      TaskData(
        id: id ?? this.id,
        course: course.present ? course.value : this.course,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, course, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.course == this.course &&
          other.description == this.description);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<int?> course;
  final Value<String> description;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    this.description = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    this.course = const Value.absent(),
    required String description,
  }) : description = Value(description);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<int>? course,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (course != null) 'course': course,
      if (description != null) 'description': description,
    });
  }

  TaskCompanion copyWith(
      {Value<int>? id, Value<int?>? course, Value<String>? description}) {
    return TaskCompanion(
      id: id ?? this.id,
      course: course ?? this.course,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (course.present) {
      map['course'] = Variable<int>(course.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('course: $course, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _courseMeta = const VerificationMeta('course');
  @override
  late final GeneratedColumn<int> course = GeneratedColumn<int>(
      'course', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, course, description];
  @override
  String get aliasedName => _alias ?? 'task';
  @override
  String get actualTableName => 'task';
  @override
  VerificationContext validateIntegrity(Insertable<TaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('course')) {
      context.handle(_courseMeta,
          course.isAcceptableOrUnknown(data['course']!, _courseMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      course: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}course']),
      description: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

class RunnignEventData extends DataClass
    implements Insertable<RunnignEventData> {
  final int id;
  final int? event;
  const RunnignEventData({required this.id, this.event});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || event != null) {
      map['event'] = Variable<int>(event);
    }
    return map;
  }

  RunnignEventCompanion toCompanion(bool nullToAbsent) {
    return RunnignEventCompanion(
      id: Value(id),
      event:
          event == null && nullToAbsent ? const Value.absent() : Value(event),
    );
  }

  factory RunnignEventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RunnignEventData(
      id: serializer.fromJson<int>(json['id']),
      event: serializer.fromJson<int?>(json['event']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'event': serializer.toJson<int?>(event),
    };
  }

  RunnignEventData copyWith(
          {int? id, Value<int?> event = const Value.absent()}) =>
      RunnignEventData(
        id: id ?? this.id,
        event: event.present ? event.value : this.event,
      );
  @override
  String toString() {
    return (StringBuffer('RunnignEventData(')
          ..write('id: $id, ')
          ..write('event: $event')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, event);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RunnignEventData &&
          other.id == this.id &&
          other.event == this.event);
}

class RunnignEventCompanion extends UpdateCompanion<RunnignEventData> {
  final Value<int> id;
  final Value<int?> event;
  const RunnignEventCompanion({
    this.id = const Value.absent(),
    this.event = const Value.absent(),
  });
  RunnignEventCompanion.insert({
    required int id,
    this.event = const Value.absent(),
  }) : id = Value(id);
  static Insertable<RunnignEventData> custom({
    Expression<int>? id,
    Expression<int>? event,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (event != null) 'event': event,
    });
  }

  RunnignEventCompanion copyWith({Value<int>? id, Value<int?>? event}) {
    return RunnignEventCompanion(
      id: id ?? this.id,
      event: event ?? this.event,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (event.present) {
      map['event'] = Variable<int>(event.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunnignEventCompanion(')
          ..write('id: $id, ')
          ..write('event: $event')
          ..write(')'))
        .toString();
  }
}

class $RunnignEventTable extends RunnignEvent
    with TableInfo<$RunnignEventTable, RunnignEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunnignEventTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<int> event = GeneratedColumn<int>(
      'event', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, event];
  @override
  String get aliasedName => _alias ?? 'runnign_event';
  @override
  String get actualTableName => 'runnign_event';
  @override
  VerificationContext validateIntegrity(Insertable<RunnignEventData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
          _eventMeta, event.isAcceptableOrUnknown(data['event']!, _eventMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  RunnignEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RunnignEventData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      event: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}event']),
    );
  }

  @override
  $RunnignEventTable createAlias(String alias) {
    return $RunnignEventTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $EventTable event = $EventTable(this);
  late final $CourseTable course = $CourseTable(this);
  late final $TaskTable task = $TaskTable(this);
  late final $RunnignEventTable runnignEvent = $RunnignEventTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [event, course, task, runnignEvent];
}

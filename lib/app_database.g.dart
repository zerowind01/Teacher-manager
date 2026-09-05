// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSuspendedMeta = const VerificationMeta(
    'isSuspended',
  );
  @override
  late final GeneratedColumn<bool> isSuspended = GeneratedColumn<bool>(
    'is_suspended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_suspended" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _initialAccumulatedLessonsMeta =
      const VerificationMeta('initialAccumulatedLessons');
  @override
  late final GeneratedColumn<double> initialAccumulatedLessons =
      GeneratedColumn<double>(
        'initial_accumulated_lessons',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _payPerLessonPriceMeta = const VerificationMeta(
    'payPerLessonPrice',
  );
  @override
  late final GeneratedColumn<double> payPerLessonPrice =
      GeneratedColumn<double>(
        'pay_per_lesson_price',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isTrialMeta = const VerificationMeta(
    'isTrial',
  );
  @override
  late final GeneratedColumn<bool> isTrial = GeneratedColumn<bool>(
    'is_trial',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_trial" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _overUsageLessonsMeta = const VerificationMeta(
    'overUsageLessons',
  );
  @override
  late final GeneratedColumn<double> overUsageLessons = GeneratedColumn<double>(
    'over_usage_lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    createdAt,
    isArchived,
    isSuspended,
    initialAccumulatedLessons,
    payPerLessonPrice,
    isTrial,
    overUsageLessons,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_suspended')) {
      context.handle(
        _isSuspendedMeta,
        isSuspended.isAcceptableOrUnknown(
          data['is_suspended']!,
          _isSuspendedMeta,
        ),
      );
    }
    if (data.containsKey('initial_accumulated_lessons')) {
      context.handle(
        _initialAccumulatedLessonsMeta,
        initialAccumulatedLessons.isAcceptableOrUnknown(
          data['initial_accumulated_lessons']!,
          _initialAccumulatedLessonsMeta,
        ),
      );
    }
    if (data.containsKey('pay_per_lesson_price')) {
      context.handle(
        _payPerLessonPriceMeta,
        payPerLessonPrice.isAcceptableOrUnknown(
          data['pay_per_lesson_price']!,
          _payPerLessonPriceMeta,
        ),
      );
    }
    if (data.containsKey('is_trial')) {
      context.handle(
        _isTrialMeta,
        isTrial.isAcceptableOrUnknown(data['is_trial']!, _isTrialMeta),
      );
    }
    if (data.containsKey('over_usage_lessons')) {
      context.handle(
        _overUsageLessonsMeta,
        overUsageLessons.isAcceptableOrUnknown(
          data['over_usage_lessons']!,
          _overUsageLessonsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isSuspended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_suspended'],
      )!,
      initialAccumulatedLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_accumulated_lessons'],
      )!,
      payPerLessonPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pay_per_lesson_price'],
      ),
      isTrial: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_trial'],
      )!,
      overUsageLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}over_usage_lessons'],
      )!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  final String? phone;
  final DateTime createdAt;
  final bool isArchived;
  final bool isSuspended;
  final double initialAccumulatedLessons;
  final double? payPerLessonPrice;
  final bool isTrial;
  final double overUsageLessons;
  const Student({
    required this.id,
    required this.name,
    this.phone,
    required this.createdAt,
    required this.isArchived,
    required this.isSuspended,
    required this.initialAccumulatedLessons,
    this.payPerLessonPrice,
    required this.isTrial,
    required this.overUsageLessons,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_suspended'] = Variable<bool>(isSuspended);
    map['initial_accumulated_lessons'] = Variable<double>(
      initialAccumulatedLessons,
    );
    if (!nullToAbsent || payPerLessonPrice != null) {
      map['pay_per_lesson_price'] = Variable<double>(payPerLessonPrice);
    }
    map['is_trial'] = Variable<bool>(isTrial);
    map['over_usage_lessons'] = Variable<double>(overUsageLessons);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      createdAt: Value(createdAt),
      isArchived: Value(isArchived),
      isSuspended: Value(isSuspended),
      initialAccumulatedLessons: Value(initialAccumulatedLessons),
      payPerLessonPrice: payPerLessonPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(payPerLessonPrice),
      isTrial: Value(isTrial),
      overUsageLessons: Value(overUsageLessons),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isSuspended: serializer.fromJson<bool>(json['isSuspended']),
      initialAccumulatedLessons: serializer.fromJson<double>(
        json['initialAccumulatedLessons'],
      ),
      payPerLessonPrice: serializer.fromJson<double?>(
        json['payPerLessonPrice'],
      ),
      isTrial: serializer.fromJson<bool>(json['isTrial']),
      overUsageLessons: serializer.fromJson<double>(json['overUsageLessons']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isSuspended': serializer.toJson<bool>(isSuspended),
      'initialAccumulatedLessons': serializer.toJson<double>(
        initialAccumulatedLessons,
      ),
      'payPerLessonPrice': serializer.toJson<double?>(payPerLessonPrice),
      'isTrial': serializer.toJson<bool>(isTrial),
      'overUsageLessons': serializer.toJson<double>(overUsageLessons),
    };
  }

  Student copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    DateTime? createdAt,
    bool? isArchived,
    bool? isSuspended,
    double? initialAccumulatedLessons,
    Value<double?> payPerLessonPrice = const Value.absent(),
    bool? isTrial,
    double? overUsageLessons,
  }) => Student(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    createdAt: createdAt ?? this.createdAt,
    isArchived: isArchived ?? this.isArchived,
    isSuspended: isSuspended ?? this.isSuspended,
    initialAccumulatedLessons:
        initialAccumulatedLessons ?? this.initialAccumulatedLessons,
    payPerLessonPrice: payPerLessonPrice.present
        ? payPerLessonPrice.value
        : this.payPerLessonPrice,
    isTrial: isTrial ?? this.isTrial,
    overUsageLessons: overUsageLessons ?? this.overUsageLessons,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isSuspended: data.isSuspended.present
          ? data.isSuspended.value
          : this.isSuspended,
      initialAccumulatedLessons: data.initialAccumulatedLessons.present
          ? data.initialAccumulatedLessons.value
          : this.initialAccumulatedLessons,
      payPerLessonPrice: data.payPerLessonPrice.present
          ? data.payPerLessonPrice.value
          : this.payPerLessonPrice,
      isTrial: data.isTrial.present ? data.isTrial.value : this.isTrial,
      overUsageLessons: data.overUsageLessons.present
          ? data.overUsageLessons.value
          : this.overUsageLessons,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSuspended: $isSuspended, ')
          ..write('initialAccumulatedLessons: $initialAccumulatedLessons, ')
          ..write('payPerLessonPrice: $payPerLessonPrice, ')
          ..write('isTrial: $isTrial, ')
          ..write('overUsageLessons: $overUsageLessons')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    createdAt,
    isArchived,
    isSuspended,
    initialAccumulatedLessons,
    payPerLessonPrice,
    isTrial,
    overUsageLessons,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.createdAt == this.createdAt &&
          other.isArchived == this.isArchived &&
          other.isSuspended == this.isSuspended &&
          other.initialAccumulatedLessons == this.initialAccumulatedLessons &&
          other.payPerLessonPrice == this.payPerLessonPrice &&
          other.isTrial == this.isTrial &&
          other.overUsageLessons == this.overUsageLessons);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<DateTime> createdAt;
  final Value<bool> isArchived;
  final Value<bool> isSuspended;
  final Value<double> initialAccumulatedLessons;
  final Value<double?> payPerLessonPrice;
  final Value<bool> isTrial;
  final Value<double> overUsageLessons;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isSuspended = const Value.absent(),
    this.initialAccumulatedLessons = const Value.absent(),
    this.payPerLessonPrice = const Value.absent(),
    this.isTrial = const Value.absent(),
    this.overUsageLessons = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isSuspended = const Value.absent(),
    this.initialAccumulatedLessons = const Value.absent(),
    this.payPerLessonPrice = const Value.absent(),
    this.isTrial = const Value.absent(),
    this.overUsageLessons = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<DateTime>? createdAt,
    Expression<bool>? isArchived,
    Expression<bool>? isSuspended,
    Expression<double>? initialAccumulatedLessons,
    Expression<double>? payPerLessonPrice,
    Expression<bool>? isTrial,
    Expression<double>? overUsageLessons,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (createdAt != null) 'created_at': createdAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (isSuspended != null) 'is_suspended': isSuspended,
      if (initialAccumulatedLessons != null)
        'initial_accumulated_lessons': initialAccumulatedLessons,
      if (payPerLessonPrice != null) 'pay_per_lesson_price': payPerLessonPrice,
      if (isTrial != null) 'is_trial': isTrial,
      if (overUsageLessons != null) 'over_usage_lessons': overUsageLessons,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<DateTime>? createdAt,
    Value<bool>? isArchived,
    Value<bool>? isSuspended,
    Value<double>? initialAccumulatedLessons,
    Value<double?>? payPerLessonPrice,
    Value<bool>? isTrial,
    Value<double>? overUsageLessons,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      isArchived: isArchived ?? this.isArchived,
      isSuspended: isSuspended ?? this.isSuspended,
      initialAccumulatedLessons:
          initialAccumulatedLessons ?? this.initialAccumulatedLessons,
      payPerLessonPrice: payPerLessonPrice ?? this.payPerLessonPrice,
      isTrial: isTrial ?? this.isTrial,
      overUsageLessons: overUsageLessons ?? this.overUsageLessons,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isSuspended.present) {
      map['is_suspended'] = Variable<bool>(isSuspended.value);
    }
    if (initialAccumulatedLessons.present) {
      map['initial_accumulated_lessons'] = Variable<double>(
        initialAccumulatedLessons.value,
      );
    }
    if (payPerLessonPrice.present) {
      map['pay_per_lesson_price'] = Variable<double>(payPerLessonPrice.value);
    }
    if (isTrial.present) {
      map['is_trial'] = Variable<bool>(isTrial.value);
    }
    if (overUsageLessons.present) {
      map['over_usage_lessons'] = Variable<double>(overUsageLessons.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSuspended: $isSuspended, ')
          ..write('initialAccumulatedLessons: $initialAccumulatedLessons, ')
          ..write('payPerLessonPrice: $payPerLessonPrice, ')
          ..write('isTrial: $isTrial, ')
          ..write('overUsageLessons: $overUsageLessons')
          ..write(')'))
        .toString();
  }
}

class $CoursePacksTable extends CoursePacks
    with TableInfo<$CoursePacksTable, CoursePack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursePacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseTypeIdMeta = const VerificationMeta(
    'courseTypeId',
  );
  @override
  late final GeneratedColumn<int> courseTypeId = GeneratedColumn<int>(
    'course_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseNameMeta = const VerificationMeta(
    'courseName',
  );
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
    'course_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLessonsMeta = const VerificationMeta(
    'totalLessons',
  );
  @override
  late final GeneratedColumn<double> totalLessons = GeneratedColumn<double>(
    'total_lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingLessonsMeta = const VerificationMeta(
    'remainingLessons',
  );
  @override
  late final GeneratedColumn<double> remainingLessons = GeneratedColumn<double>(
    'remaining_lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialAccumulatedLessonsMeta =
      const VerificationMeta('initialAccumulatedLessons');
  @override
  late final GeneratedColumn<double> initialAccumulatedLessons =
      GeneratedColumn<double>(
        'initial_accumulated_lessons',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    courseTypeId,
    courseName,
    totalLessons,
    remainingLessons,
    unitPrice,
    initialAccumulatedLessons,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoursePack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_type_id')) {
      context.handle(
        _courseTypeIdMeta,
        courseTypeId.isAcceptableOrUnknown(
          data['course_type_id']!,
          _courseTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('course_name')) {
      context.handle(
        _courseNameMeta,
        courseName.isAcceptableOrUnknown(data['course_name']!, _courseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_courseNameMeta);
    }
    if (data.containsKey('total_lessons')) {
      context.handle(
        _totalLessonsMeta,
        totalLessons.isAcceptableOrUnknown(
          data['total_lessons']!,
          _totalLessonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLessonsMeta);
    }
    if (data.containsKey('remaining_lessons')) {
      context.handle(
        _remainingLessonsMeta,
        remainingLessons.isAcceptableOrUnknown(
          data['remaining_lessons']!,
          _remainingLessonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingLessonsMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('initial_accumulated_lessons')) {
      context.handle(
        _initialAccumulatedLessonsMeta,
        initialAccumulatedLessons.isAcceptableOrUnknown(
          data['initial_accumulated_lessons']!,
          _initialAccumulatedLessonsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoursePack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoursePack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      courseTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_type_id'],
      ),
      courseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_name'],
      )!,
      totalLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_lessons'],
      )!,
      remainingLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_lessons'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      initialAccumulatedLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_accumulated_lessons'],
      )!,
    );
  }

  @override
  $CoursePacksTable createAlias(String alias) {
    return $CoursePacksTable(attachedDatabase, alias);
  }
}

class CoursePack extends DataClass implements Insertable<CoursePack> {
  final int id;
  final int studentId;
  final int? courseTypeId;
  final String courseName;
  final double totalLessons;
  final double remainingLessons;
  final double unitPrice;
  final double initialAccumulatedLessons;
  const CoursePack({
    required this.id,
    required this.studentId,
    this.courseTypeId,
    required this.courseName,
    required this.totalLessons,
    required this.remainingLessons,
    required this.unitPrice,
    required this.initialAccumulatedLessons,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || courseTypeId != null) {
      map['course_type_id'] = Variable<int>(courseTypeId);
    }
    map['course_name'] = Variable<String>(courseName);
    map['total_lessons'] = Variable<double>(totalLessons);
    map['remaining_lessons'] = Variable<double>(remainingLessons);
    map['unit_price'] = Variable<double>(unitPrice);
    map['initial_accumulated_lessons'] = Variable<double>(
      initialAccumulatedLessons,
    );
    return map;
  }

  CoursePacksCompanion toCompanion(bool nullToAbsent) {
    return CoursePacksCompanion(
      id: Value(id),
      studentId: Value(studentId),
      courseTypeId: courseTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(courseTypeId),
      courseName: Value(courseName),
      totalLessons: Value(totalLessons),
      remainingLessons: Value(remainingLessons),
      unitPrice: Value(unitPrice),
      initialAccumulatedLessons: Value(initialAccumulatedLessons),
    );
  }

  factory CoursePack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoursePack(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      courseTypeId: serializer.fromJson<int?>(json['courseTypeId']),
      courseName: serializer.fromJson<String>(json['courseName']),
      totalLessons: serializer.fromJson<double>(json['totalLessons']),
      remainingLessons: serializer.fromJson<double>(json['remainingLessons']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      initialAccumulatedLessons: serializer.fromJson<double>(
        json['initialAccumulatedLessons'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'courseTypeId': serializer.toJson<int?>(courseTypeId),
      'courseName': serializer.toJson<String>(courseName),
      'totalLessons': serializer.toJson<double>(totalLessons),
      'remainingLessons': serializer.toJson<double>(remainingLessons),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'initialAccumulatedLessons': serializer.toJson<double>(
        initialAccumulatedLessons,
      ),
    };
  }

  CoursePack copyWith({
    int? id,
    int? studentId,
    Value<int?> courseTypeId = const Value.absent(),
    String? courseName,
    double? totalLessons,
    double? remainingLessons,
    double? unitPrice,
    double? initialAccumulatedLessons,
  }) => CoursePack(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    courseTypeId: courseTypeId.present ? courseTypeId.value : this.courseTypeId,
    courseName: courseName ?? this.courseName,
    totalLessons: totalLessons ?? this.totalLessons,
    remainingLessons: remainingLessons ?? this.remainingLessons,
    unitPrice: unitPrice ?? this.unitPrice,
    initialAccumulatedLessons:
        initialAccumulatedLessons ?? this.initialAccumulatedLessons,
  );
  CoursePack copyWithCompanion(CoursePacksCompanion data) {
    return CoursePack(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      courseTypeId: data.courseTypeId.present
          ? data.courseTypeId.value
          : this.courseTypeId,
      courseName: data.courseName.present
          ? data.courseName.value
          : this.courseName,
      totalLessons: data.totalLessons.present
          ? data.totalLessons.value
          : this.totalLessons,
      remainingLessons: data.remainingLessons.present
          ? data.remainingLessons.value
          : this.remainingLessons,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      initialAccumulatedLessons: data.initialAccumulatedLessons.present
          ? data.initialAccumulatedLessons.value
          : this.initialAccumulatedLessons,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoursePack(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('courseName: $courseName, ')
          ..write('totalLessons: $totalLessons, ')
          ..write('remainingLessons: $remainingLessons, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('initialAccumulatedLessons: $initialAccumulatedLessons')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    courseTypeId,
    courseName,
    totalLessons,
    remainingLessons,
    unitPrice,
    initialAccumulatedLessons,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoursePack &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.courseTypeId == this.courseTypeId &&
          other.courseName == this.courseName &&
          other.totalLessons == this.totalLessons &&
          other.remainingLessons == this.remainingLessons &&
          other.unitPrice == this.unitPrice &&
          other.initialAccumulatedLessons == this.initialAccumulatedLessons);
}

class CoursePacksCompanion extends UpdateCompanion<CoursePack> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int?> courseTypeId;
  final Value<String> courseName;
  final Value<double> totalLessons;
  final Value<double> remainingLessons;
  final Value<double> unitPrice;
  final Value<double> initialAccumulatedLessons;
  const CoursePacksCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    this.courseName = const Value.absent(),
    this.totalLessons = const Value.absent(),
    this.remainingLessons = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.initialAccumulatedLessons = const Value.absent(),
  });
  CoursePacksCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    this.courseTypeId = const Value.absent(),
    required String courseName,
    required double totalLessons,
    required double remainingLessons,
    required double unitPrice,
    this.initialAccumulatedLessons = const Value.absent(),
  }) : studentId = Value(studentId),
       courseName = Value(courseName),
       totalLessons = Value(totalLessons),
       remainingLessons = Value(remainingLessons),
       unitPrice = Value(unitPrice);
  static Insertable<CoursePack> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? courseTypeId,
    Expression<String>? courseName,
    Expression<double>? totalLessons,
    Expression<double>? remainingLessons,
    Expression<double>? unitPrice,
    Expression<double>? initialAccumulatedLessons,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (courseTypeId != null) 'course_type_id': courseTypeId,
      if (courseName != null) 'course_name': courseName,
      if (totalLessons != null) 'total_lessons': totalLessons,
      if (remainingLessons != null) 'remaining_lessons': remainingLessons,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (initialAccumulatedLessons != null)
        'initial_accumulated_lessons': initialAccumulatedLessons,
    });
  }

  CoursePacksCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int?>? courseTypeId,
    Value<String>? courseName,
    Value<double>? totalLessons,
    Value<double>? remainingLessons,
    Value<double>? unitPrice,
    Value<double>? initialAccumulatedLessons,
  }) {
    return CoursePacksCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseTypeId: courseTypeId ?? this.courseTypeId,
      courseName: courseName ?? this.courseName,
      totalLessons: totalLessons ?? this.totalLessons,
      remainingLessons: remainingLessons ?? this.remainingLessons,
      unitPrice: unitPrice ?? this.unitPrice,
      initialAccumulatedLessons:
          initialAccumulatedLessons ?? this.initialAccumulatedLessons,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (courseTypeId.present) {
      map['course_type_id'] = Variable<int>(courseTypeId.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (totalLessons.present) {
      map['total_lessons'] = Variable<double>(totalLessons.value);
    }
    if (remainingLessons.present) {
      map['remaining_lessons'] = Variable<double>(remainingLessons.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (initialAccumulatedLessons.present) {
      map['initial_accumulated_lessons'] = Variable<double>(
        initialAccumulatedLessons.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursePacksCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('courseName: $courseName, ')
          ..write('totalLessons: $totalLessons, ')
          ..write('remainingLessons: $remainingLessons, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('initialAccumulatedLessons: $initialAccumulatedLessons')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coursePackIdMeta = const VerificationMeta(
    'coursePackId',
  );
  @override
  late final GeneratedColumn<int> coursePackId = GeneratedColumn<int>(
    'course_pack_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseTypeIdMeta = const VerificationMeta(
    'courseTypeId',
  );
  @override
  late final GeneratedColumn<int> courseTypeId = GeneratedColumn<int>(
    'course_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonDeductionMeta = const VerificationMeta(
    'lessonDeduction',
  );
  @override
  late final GeneratedColumn<double> lessonDeduction = GeneratedColumn<double>(
    'lesson_deduction',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ScheduleStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ScheduleStatus.scheduled.index),
      ).withConverter<ScheduleStatus>($SchedulesTable.$converterstatus);
  static const VerificationMeta _systemEventIdMeta = const VerificationMeta(
    'systemEventId',
  );
  @override
  late final GeneratedColumn<String> systemEventId = GeneratedColumn<String>(
    'system_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurringGroupIdMeta = const VerificationMeta(
    'recurringGroupId',
  );
  @override
  late final GeneratedColumn<String> recurringGroupId = GeneratedColumn<String>(
    'recurring_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    coursePackId,
    courseTypeId,
    startTime,
    endTime,
    lessonDeduction,
    status,
    systemEventId,
    recurringGroupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Schedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_pack_id')) {
      context.handle(
        _coursePackIdMeta,
        coursePackId.isAcceptableOrUnknown(
          data['course_pack_id']!,
          _coursePackIdMeta,
        ),
      );
    }
    if (data.containsKey('course_type_id')) {
      context.handle(
        _courseTypeIdMeta,
        courseTypeId.isAcceptableOrUnknown(
          data['course_type_id']!,
          _courseTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('lesson_deduction')) {
      context.handle(
        _lessonDeductionMeta,
        lessonDeduction.isAcceptableOrUnknown(
          data['lesson_deduction']!,
          _lessonDeductionMeta,
        ),
      );
    }
    if (data.containsKey('system_event_id')) {
      context.handle(
        _systemEventIdMeta,
        systemEventId.isAcceptableOrUnknown(
          data['system_event_id']!,
          _systemEventIdMeta,
        ),
      );
    }
    if (data.containsKey('recurring_group_id')) {
      context.handle(
        _recurringGroupIdMeta,
        recurringGroupId.isAcceptableOrUnknown(
          data['recurring_group_id']!,
          _recurringGroupIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      coursePackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_pack_id'],
      ),
      courseTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_type_id'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      lessonDeduction: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lesson_deduction'],
      )!,
      status: $SchedulesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      systemEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_event_id'],
      ),
      recurringGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurring_group_id'],
      ),
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ScheduleStatus, int, int> $converterstatus =
      const EnumIndexConverter<ScheduleStatus>(ScheduleStatus.values);
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final int studentId;
  final int? coursePackId;
  final int? courseTypeId;
  final DateTime startTime;
  final DateTime endTime;
  final double lessonDeduction;
  final ScheduleStatus status;
  final String? systemEventId;
  final String? recurringGroupId;
  const Schedule({
    required this.id,
    required this.studentId,
    this.coursePackId,
    this.courseTypeId,
    required this.startTime,
    required this.endTime,
    required this.lessonDeduction,
    required this.status,
    this.systemEventId,
    this.recurringGroupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || coursePackId != null) {
      map['course_pack_id'] = Variable<int>(coursePackId);
    }
    if (!nullToAbsent || courseTypeId != null) {
      map['course_type_id'] = Variable<int>(courseTypeId);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['lesson_deduction'] = Variable<double>(lessonDeduction);
    {
      map['status'] = Variable<int>(
        $SchedulesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || systemEventId != null) {
      map['system_event_id'] = Variable<String>(systemEventId);
    }
    if (!nullToAbsent || recurringGroupId != null) {
      map['recurring_group_id'] = Variable<String>(recurringGroupId);
    }
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      coursePackId: coursePackId == null && nullToAbsent
          ? const Value.absent()
          : Value(coursePackId),
      courseTypeId: courseTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(courseTypeId),
      startTime: Value(startTime),
      endTime: Value(endTime),
      lessonDeduction: Value(lessonDeduction),
      status: Value(status),
      systemEventId: systemEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(systemEventId),
      recurringGroupId: recurringGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurringGroupId),
    );
  }

  factory Schedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      coursePackId: serializer.fromJson<int?>(json['coursePackId']),
      courseTypeId: serializer.fromJson<int?>(json['courseTypeId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      lessonDeduction: serializer.fromJson<double>(json['lessonDeduction']),
      status: $SchedulesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      systemEventId: serializer.fromJson<String?>(json['systemEventId']),
      recurringGroupId: serializer.fromJson<String?>(json['recurringGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'coursePackId': serializer.toJson<int?>(coursePackId),
      'courseTypeId': serializer.toJson<int?>(courseTypeId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'lessonDeduction': serializer.toJson<double>(lessonDeduction),
      'status': serializer.toJson<int>(
        $SchedulesTable.$converterstatus.toJson(status),
      ),
      'systemEventId': serializer.toJson<String?>(systemEventId),
      'recurringGroupId': serializer.toJson<String?>(recurringGroupId),
    };
  }

  Schedule copyWith({
    int? id,
    int? studentId,
    Value<int?> coursePackId = const Value.absent(),
    Value<int?> courseTypeId = const Value.absent(),
    DateTime? startTime,
    DateTime? endTime,
    double? lessonDeduction,
    ScheduleStatus? status,
    Value<String?> systemEventId = const Value.absent(),
    Value<String?> recurringGroupId = const Value.absent(),
  }) => Schedule(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    coursePackId: coursePackId.present ? coursePackId.value : this.coursePackId,
    courseTypeId: courseTypeId.present ? courseTypeId.value : this.courseTypeId,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    lessonDeduction: lessonDeduction ?? this.lessonDeduction,
    status: status ?? this.status,
    systemEventId: systemEventId.present
        ? systemEventId.value
        : this.systemEventId,
    recurringGroupId: recurringGroupId.present
        ? recurringGroupId.value
        : this.recurringGroupId,
  );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      coursePackId: data.coursePackId.present
          ? data.coursePackId.value
          : this.coursePackId,
      courseTypeId: data.courseTypeId.present
          ? data.courseTypeId.value
          : this.courseTypeId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      lessonDeduction: data.lessonDeduction.present
          ? data.lessonDeduction.value
          : this.lessonDeduction,
      status: data.status.present ? data.status.value : this.status,
      systemEventId: data.systemEventId.present
          ? data.systemEventId.value
          : this.systemEventId,
      recurringGroupId: data.recurringGroupId.present
          ? data.recurringGroupId.value
          : this.recurringGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lessonDeduction: $lessonDeduction, ')
          ..write('status: $status, ')
          ..write('systemEventId: $systemEventId, ')
          ..write('recurringGroupId: $recurringGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    coursePackId,
    courseTypeId,
    startTime,
    endTime,
    lessonDeduction,
    status,
    systemEventId,
    recurringGroupId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.coursePackId == this.coursePackId &&
          other.courseTypeId == this.courseTypeId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.lessonDeduction == this.lessonDeduction &&
          other.status == this.status &&
          other.systemEventId == this.systemEventId &&
          other.recurringGroupId == this.recurringGroupId);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int?> coursePackId;
  final Value<int?> courseTypeId;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<double> lessonDeduction;
  final Value<ScheduleStatus> status;
  final Value<String?> systemEventId;
  final Value<String?> recurringGroupId;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.coursePackId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.lessonDeduction = const Value.absent(),
    this.status = const Value.absent(),
    this.systemEventId = const Value.absent(),
    this.recurringGroupId = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    this.coursePackId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    required DateTime startTime,
    required DateTime endTime,
    this.lessonDeduction = const Value.absent(),
    this.status = const Value.absent(),
    this.systemEventId = const Value.absent(),
    this.recurringGroupId = const Value.absent(),
  }) : studentId = Value(studentId),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? coursePackId,
    Expression<int>? courseTypeId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<double>? lessonDeduction,
    Expression<int>? status,
    Expression<String>? systemEventId,
    Expression<String>? recurringGroupId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (coursePackId != null) 'course_pack_id': coursePackId,
      if (courseTypeId != null) 'course_type_id': courseTypeId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (lessonDeduction != null) 'lesson_deduction': lessonDeduction,
      if (status != null) 'status': status,
      if (systemEventId != null) 'system_event_id': systemEventId,
      if (recurringGroupId != null) 'recurring_group_id': recurringGroupId,
    });
  }

  SchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int?>? coursePackId,
    Value<int?>? courseTypeId,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<double>? lessonDeduction,
    Value<ScheduleStatus>? status,
    Value<String?>? systemEventId,
    Value<String?>? recurringGroupId,
  }) {
    return SchedulesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      coursePackId: coursePackId ?? this.coursePackId,
      courseTypeId: courseTypeId ?? this.courseTypeId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      lessonDeduction: lessonDeduction ?? this.lessonDeduction,
      status: status ?? this.status,
      systemEventId: systemEventId ?? this.systemEventId,
      recurringGroupId: recurringGroupId ?? this.recurringGroupId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (coursePackId.present) {
      map['course_pack_id'] = Variable<int>(coursePackId.value);
    }
    if (courseTypeId.present) {
      map['course_type_id'] = Variable<int>(courseTypeId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (lessonDeduction.present) {
      map['lesson_deduction'] = Variable<double>(lessonDeduction.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $SchedulesTable.$converterstatus.toSql(status.value),
      );
    }
    if (systemEventId.present) {
      map['system_event_id'] = Variable<String>(systemEventId.value);
    }
    if (recurringGroupId.present) {
      map['recurring_group_id'] = Variable<String>(recurringGroupId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('lessonDeduction: $lessonDeduction, ')
          ..write('status: $status, ')
          ..write('systemEventId: $systemEventId, ')
          ..write('recurringGroupId: $recurringGroupId')
          ..write(')'))
        .toString();
  }
}

class $CheckInLogsTable extends CheckInLogs
    with TableInfo<$CheckInLogsTable, CheckInLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scheduleIdMeta = const VerificationMeta(
    'scheduleId',
  );
  @override
  late final GeneratedColumn<int> scheduleId = GeneratedColumn<int>(
    'schedule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coursePackIdMeta = const VerificationMeta(
    'coursePackId',
  );
  @override
  late final GeneratedColumn<int> coursePackId = GeneratedColumn<int>(
    'course_pack_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseTypeIdMeta = const VerificationMeta(
    'courseTypeId',
  );
  @override
  late final GeneratedColumn<int> courseTypeId = GeneratedColumn<int>(
    'course_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deductedLessonsMeta = const VerificationMeta(
    'deductedLessons',
  );
  @override
  late final GeneratedColumn<double> deductedLessons = GeneratedColumn<double>(
    'deducted_lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInTimeMeta = const VerificationMeta(
    'checkInTime',
  );
  @override
  late final GeneratedColumn<DateTime> checkInTime = GeneratedColumn<DateTime>(
    'check_in_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentAmountMeta = const VerificationMeta(
    'paymentAmount',
  );
  @override
  late final GeneratedColumn<double> paymentAmount = GeneratedColumn<double>(
    'payment_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scheduleId,
    studentId,
    coursePackId,
    courseTypeId,
    deductedLessons,
    checkInTime,
    remarks,
    paymentAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_in_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
        _scheduleIdMeta,
        scheduleId.isAcceptableOrUnknown(data['schedule_id']!, _scheduleIdMeta),
      );
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_pack_id')) {
      context.handle(
        _coursePackIdMeta,
        coursePackId.isAcceptableOrUnknown(
          data['course_pack_id']!,
          _coursePackIdMeta,
        ),
      );
    }
    if (data.containsKey('course_type_id')) {
      context.handle(
        _courseTypeIdMeta,
        courseTypeId.isAcceptableOrUnknown(
          data['course_type_id']!,
          _courseTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('deducted_lessons')) {
      context.handle(
        _deductedLessonsMeta,
        deductedLessons.isAcceptableOrUnknown(
          data['deducted_lessons']!,
          _deductedLessonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductedLessonsMeta);
    }
    if (data.containsKey('check_in_time')) {
      context.handle(
        _checkInTimeMeta,
        checkInTime.isAcceptableOrUnknown(
          data['check_in_time']!,
          _checkInTimeMeta,
        ),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('payment_amount')) {
      context.handle(
        _paymentAmountMeta,
        paymentAmount.isAcceptableOrUnknown(
          data['payment_amount']!,
          _paymentAmountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckInLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scheduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_id'],
      ),
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      coursePackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_pack_id'],
      ),
      courseTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_type_id'],
      ),
      deductedLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deducted_lessons'],
      )!,
      checkInTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in_time'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      paymentAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payment_amount'],
      )!,
    );
  }

  @override
  $CheckInLogsTable createAlias(String alias) {
    return $CheckInLogsTable(attachedDatabase, alias);
  }
}

class CheckInLog extends DataClass implements Insertable<CheckInLog> {
  final int id;
  final int? scheduleId;
  final int studentId;
  final int? coursePackId;
  final int? courseTypeId;
  final double deductedLessons;
  final DateTime checkInTime;
  final String? remarks;
  final double paymentAmount;
  const CheckInLog({
    required this.id,
    this.scheduleId,
    required this.studentId,
    this.coursePackId,
    this.courseTypeId,
    required this.deductedLessons,
    required this.checkInTime,
    this.remarks,
    required this.paymentAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<int>(scheduleId);
    }
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || coursePackId != null) {
      map['course_pack_id'] = Variable<int>(coursePackId);
    }
    if (!nullToAbsent || courseTypeId != null) {
      map['course_type_id'] = Variable<int>(courseTypeId);
    }
    map['deducted_lessons'] = Variable<double>(deductedLessons);
    map['check_in_time'] = Variable<DateTime>(checkInTime);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    map['payment_amount'] = Variable<double>(paymentAmount);
    return map;
  }

  CheckInLogsCompanion toCompanion(bool nullToAbsent) {
    return CheckInLogsCompanion(
      id: Value(id),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
      studentId: Value(studentId),
      coursePackId: coursePackId == null && nullToAbsent
          ? const Value.absent()
          : Value(coursePackId),
      courseTypeId: courseTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(courseTypeId),
      deductedLessons: Value(deductedLessons),
      checkInTime: Value(checkInTime),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      paymentAmount: Value(paymentAmount),
    );
  }

  factory CheckInLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInLog(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<int?>(json['scheduleId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      coursePackId: serializer.fromJson<int?>(json['coursePackId']),
      courseTypeId: serializer.fromJson<int?>(json['courseTypeId']),
      deductedLessons: serializer.fromJson<double>(json['deductedLessons']),
      checkInTime: serializer.fromJson<DateTime>(json['checkInTime']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      paymentAmount: serializer.fromJson<double>(json['paymentAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<int?>(scheduleId),
      'studentId': serializer.toJson<int>(studentId),
      'coursePackId': serializer.toJson<int?>(coursePackId),
      'courseTypeId': serializer.toJson<int?>(courseTypeId),
      'deductedLessons': serializer.toJson<double>(deductedLessons),
      'checkInTime': serializer.toJson<DateTime>(checkInTime),
      'remarks': serializer.toJson<String?>(remarks),
      'paymentAmount': serializer.toJson<double>(paymentAmount),
    };
  }

  CheckInLog copyWith({
    int? id,
    Value<int?> scheduleId = const Value.absent(),
    int? studentId,
    Value<int?> coursePackId = const Value.absent(),
    Value<int?> courseTypeId = const Value.absent(),
    double? deductedLessons,
    DateTime? checkInTime,
    Value<String?> remarks = const Value.absent(),
    double? paymentAmount,
  }) => CheckInLog(
    id: id ?? this.id,
    scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
    studentId: studentId ?? this.studentId,
    coursePackId: coursePackId.present ? coursePackId.value : this.coursePackId,
    courseTypeId: courseTypeId.present ? courseTypeId.value : this.courseTypeId,
    deductedLessons: deductedLessons ?? this.deductedLessons,
    checkInTime: checkInTime ?? this.checkInTime,
    remarks: remarks.present ? remarks.value : this.remarks,
    paymentAmount: paymentAmount ?? this.paymentAmount,
  );
  CheckInLog copyWithCompanion(CheckInLogsCompanion data) {
    return CheckInLog(
      id: data.id.present ? data.id.value : this.id,
      scheduleId: data.scheduleId.present
          ? data.scheduleId.value
          : this.scheduleId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      coursePackId: data.coursePackId.present
          ? data.coursePackId.value
          : this.coursePackId,
      courseTypeId: data.courseTypeId.present
          ? data.courseTypeId.value
          : this.courseTypeId,
      deductedLessons: data.deductedLessons.present
          ? data.deductedLessons.value
          : this.deductedLessons,
      checkInTime: data.checkInTime.present
          ? data.checkInTime.value
          : this.checkInTime,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      paymentAmount: data.paymentAmount.present
          ? data.paymentAmount.value
          : this.paymentAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInLog(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('deductedLessons: $deductedLessons, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('remarks: $remarks, ')
          ..write('paymentAmount: $paymentAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scheduleId,
    studentId,
    coursePackId,
    courseTypeId,
    deductedLessons,
    checkInTime,
    remarks,
    paymentAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInLog &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.studentId == this.studentId &&
          other.coursePackId == this.coursePackId &&
          other.courseTypeId == this.courseTypeId &&
          other.deductedLessons == this.deductedLessons &&
          other.checkInTime == this.checkInTime &&
          other.remarks == this.remarks &&
          other.paymentAmount == this.paymentAmount);
}

class CheckInLogsCompanion extends UpdateCompanion<CheckInLog> {
  final Value<int> id;
  final Value<int?> scheduleId;
  final Value<int> studentId;
  final Value<int?> coursePackId;
  final Value<int?> courseTypeId;
  final Value<double> deductedLessons;
  final Value<DateTime> checkInTime;
  final Value<String?> remarks;
  final Value<double> paymentAmount;
  const CheckInLogsCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.coursePackId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    this.deductedLessons = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.remarks = const Value.absent(),
    this.paymentAmount = const Value.absent(),
  });
  CheckInLogsCompanion.insert({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    required int studentId,
    this.coursePackId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    required double deductedLessons,
    this.checkInTime = const Value.absent(),
    this.remarks = const Value.absent(),
    this.paymentAmount = const Value.absent(),
  }) : studentId = Value(studentId),
       deductedLessons = Value(deductedLessons);
  static Insertable<CheckInLog> custom({
    Expression<int>? id,
    Expression<int>? scheduleId,
    Expression<int>? studentId,
    Expression<int>? coursePackId,
    Expression<int>? courseTypeId,
    Expression<double>? deductedLessons,
    Expression<DateTime>? checkInTime,
    Expression<String>? remarks,
    Expression<double>? paymentAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (studentId != null) 'student_id': studentId,
      if (coursePackId != null) 'course_pack_id': coursePackId,
      if (courseTypeId != null) 'course_type_id': courseTypeId,
      if (deductedLessons != null) 'deducted_lessons': deductedLessons,
      if (checkInTime != null) 'check_in_time': checkInTime,
      if (remarks != null) 'remarks': remarks,
      if (paymentAmount != null) 'payment_amount': paymentAmount,
    });
  }

  CheckInLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? scheduleId,
    Value<int>? studentId,
    Value<int?>? coursePackId,
    Value<int?>? courseTypeId,
    Value<double>? deductedLessons,
    Value<DateTime>? checkInTime,
    Value<String?>? remarks,
    Value<double>? paymentAmount,
  }) {
    return CheckInLogsCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      studentId: studentId ?? this.studentId,
      coursePackId: coursePackId ?? this.coursePackId,
      courseTypeId: courseTypeId ?? this.courseTypeId,
      deductedLessons: deductedLessons ?? this.deductedLessons,
      checkInTime: checkInTime ?? this.checkInTime,
      remarks: remarks ?? this.remarks,
      paymentAmount: paymentAmount ?? this.paymentAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<int>(scheduleId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (coursePackId.present) {
      map['course_pack_id'] = Variable<int>(coursePackId.value);
    }
    if (courseTypeId.present) {
      map['course_type_id'] = Variable<int>(courseTypeId.value);
    }
    if (deductedLessons.present) {
      map['deducted_lessons'] = Variable<double>(deductedLessons.value);
    }
    if (checkInTime.present) {
      map['check_in_time'] = Variable<DateTime>(checkInTime.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (paymentAmount.present) {
      map['payment_amount'] = Variable<double>(paymentAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInLogsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('deductedLessons: $deductedLessons, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('remarks: $remarks, ')
          ..write('paymentAmount: $paymentAmount')
          ..write(')'))
        .toString();
  }
}

class $RefundLogsTable extends RefundLogs
    with TableInfo<$RefundLogsTable, RefundLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RefundLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coursePackIdMeta = const VerificationMeta(
    'coursePackId',
  );
  @override
  late final GeneratedColumn<int> coursePackId = GeneratedColumn<int>(
    'course_pack_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deductedLessonsMeta = const VerificationMeta(
    'deductedLessons',
  );
  @override
  late final GeneratedColumn<double> deductedLessons = GeneratedColumn<double>(
    'deducted_lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundTimeMeta = const VerificationMeta(
    'refundTime',
  );
  @override
  late final GeneratedColumn<DateTime> refundTime = GeneratedColumn<DateTime>(
    'refund_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    coursePackId,
    refundAmount,
    deductedLessons,
    refundTime,
    remarks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'refund_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RefundLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_pack_id')) {
      context.handle(
        _coursePackIdMeta,
        coursePackId.isAcceptableOrUnknown(
          data['course_pack_id']!,
          _coursePackIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coursePackIdMeta);
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refundAmountMeta);
    }
    if (data.containsKey('deducted_lessons')) {
      context.handle(
        _deductedLessonsMeta,
        deductedLessons.isAcceptableOrUnknown(
          data['deducted_lessons']!,
          _deductedLessonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductedLessonsMeta);
    }
    if (data.containsKey('refund_time')) {
      context.handle(
        _refundTimeMeta,
        refundTime.isAcceptableOrUnknown(data['refund_time']!, _refundTimeMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RefundLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RefundLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      coursePackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_pack_id'],
      )!,
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      )!,
      deductedLessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}deducted_lessons'],
      )!,
      refundTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}refund_time'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
    );
  }

  @override
  $RefundLogsTable createAlias(String alias) {
    return $RefundLogsTable(attachedDatabase, alias);
  }
}

class RefundLog extends DataClass implements Insertable<RefundLog> {
  final int id;
  final int studentId;
  final int coursePackId;
  final double refundAmount;
  final double deductedLessons;
  final DateTime refundTime;
  final String? remarks;
  const RefundLog({
    required this.id,
    required this.studentId,
    required this.coursePackId,
    required this.refundAmount,
    required this.deductedLessons,
    required this.refundTime,
    this.remarks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['course_pack_id'] = Variable<int>(coursePackId);
    map['refund_amount'] = Variable<double>(refundAmount);
    map['deducted_lessons'] = Variable<double>(deductedLessons);
    map['refund_time'] = Variable<DateTime>(refundTime);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    return map;
  }

  RefundLogsCompanion toCompanion(bool nullToAbsent) {
    return RefundLogsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      coursePackId: Value(coursePackId),
      refundAmount: Value(refundAmount),
      deductedLessons: Value(deductedLessons),
      refundTime: Value(refundTime),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
    );
  }

  factory RefundLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RefundLog(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      coursePackId: serializer.fromJson<int>(json['coursePackId']),
      refundAmount: serializer.fromJson<double>(json['refundAmount']),
      deductedLessons: serializer.fromJson<double>(json['deductedLessons']),
      refundTime: serializer.fromJson<DateTime>(json['refundTime']),
      remarks: serializer.fromJson<String?>(json['remarks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'coursePackId': serializer.toJson<int>(coursePackId),
      'refundAmount': serializer.toJson<double>(refundAmount),
      'deductedLessons': serializer.toJson<double>(deductedLessons),
      'refundTime': serializer.toJson<DateTime>(refundTime),
      'remarks': serializer.toJson<String?>(remarks),
    };
  }

  RefundLog copyWith({
    int? id,
    int? studentId,
    int? coursePackId,
    double? refundAmount,
    double? deductedLessons,
    DateTime? refundTime,
    Value<String?> remarks = const Value.absent(),
  }) => RefundLog(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    coursePackId: coursePackId ?? this.coursePackId,
    refundAmount: refundAmount ?? this.refundAmount,
    deductedLessons: deductedLessons ?? this.deductedLessons,
    refundTime: refundTime ?? this.refundTime,
    remarks: remarks.present ? remarks.value : this.remarks,
  );
  RefundLog copyWithCompanion(RefundLogsCompanion data) {
    return RefundLog(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      coursePackId: data.coursePackId.present
          ? data.coursePackId.value
          : this.coursePackId,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      deductedLessons: data.deductedLessons.present
          ? data.deductedLessons.value
          : this.deductedLessons,
      refundTime: data.refundTime.present
          ? data.refundTime.value
          : this.refundTime,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RefundLog(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('deductedLessons: $deductedLessons, ')
          ..write('refundTime: $refundTime, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    coursePackId,
    refundAmount,
    deductedLessons,
    refundTime,
    remarks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RefundLog &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.coursePackId == this.coursePackId &&
          other.refundAmount == this.refundAmount &&
          other.deductedLessons == this.deductedLessons &&
          other.refundTime == this.refundTime &&
          other.remarks == this.remarks);
}

class RefundLogsCompanion extends UpdateCompanion<RefundLog> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> coursePackId;
  final Value<double> refundAmount;
  final Value<double> deductedLessons;
  final Value<DateTime> refundTime;
  final Value<String?> remarks;
  const RefundLogsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.coursePackId = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.deductedLessons = const Value.absent(),
    this.refundTime = const Value.absent(),
    this.remarks = const Value.absent(),
  });
  RefundLogsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int coursePackId,
    required double refundAmount,
    required double deductedLessons,
    this.refundTime = const Value.absent(),
    this.remarks = const Value.absent(),
  }) : studentId = Value(studentId),
       coursePackId = Value(coursePackId),
       refundAmount = Value(refundAmount),
       deductedLessons = Value(deductedLessons);
  static Insertable<RefundLog> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? coursePackId,
    Expression<double>? refundAmount,
    Expression<double>? deductedLessons,
    Expression<DateTime>? refundTime,
    Expression<String>? remarks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (coursePackId != null) 'course_pack_id': coursePackId,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (deductedLessons != null) 'deducted_lessons': deductedLessons,
      if (refundTime != null) 'refund_time': refundTime,
      if (remarks != null) 'remarks': remarks,
    });
  }

  RefundLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? coursePackId,
    Value<double>? refundAmount,
    Value<double>? deductedLessons,
    Value<DateTime>? refundTime,
    Value<String?>? remarks,
  }) {
    return RefundLogsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      coursePackId: coursePackId ?? this.coursePackId,
      refundAmount: refundAmount ?? this.refundAmount,
      deductedLessons: deductedLessons ?? this.deductedLessons,
      refundTime: refundTime ?? this.refundTime,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (coursePackId.present) {
      map['course_pack_id'] = Variable<int>(coursePackId.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (deductedLessons.present) {
      map['deducted_lessons'] = Variable<double>(deductedLessons.value);
    }
    if (refundTime.present) {
      map['refund_time'] = Variable<DateTime>(refundTime.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RefundLogsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('deductedLessons: $deductedLessons, ')
          ..write('refundTime: $refundTime, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }
}

class $PurchaseLogsTable extends PurchaseLogs
    with TableInfo<$PurchaseLogsTable, PurchaseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coursePackIdMeta = const VerificationMeta(
    'coursePackId',
  );
  @override
  late final GeneratedColumn<int> coursePackId = GeneratedColumn<int>(
    'course_pack_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _courseNameMeta = const VerificationMeta(
    'courseName',
  );
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
    'course_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonsMeta = const VerificationMeta(
    'lessons',
  );
  @override
  late final GeneratedColumn<double> lessons = GeneratedColumn<double>(
    'lessons',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseTimeMeta = const VerificationMeta(
    'purchaseTime',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseTime = GeneratedColumn<DateTime>(
    'purchase_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    coursePackId,
    courseName,
    amount,
    lessons,
    purchaseTime,
    remarks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_pack_id')) {
      context.handle(
        _coursePackIdMeta,
        coursePackId.isAcceptableOrUnknown(
          data['course_pack_id']!,
          _coursePackIdMeta,
        ),
      );
    }
    if (data.containsKey('course_name')) {
      context.handle(
        _courseNameMeta,
        courseName.isAcceptableOrUnknown(data['course_name']!, _courseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_courseNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('lessons')) {
      context.handle(
        _lessonsMeta,
        lessons.isAcceptableOrUnknown(data['lessons']!, _lessonsMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonsMeta);
    }
    if (data.containsKey('purchase_time')) {
      context.handle(
        _purchaseTimeMeta,
        purchaseTime.isAcceptableOrUnknown(
          data['purchase_time']!,
          _purchaseTimeMeta,
        ),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      coursePackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_pack_id'],
      ),
      courseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      lessons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lessons'],
      )!,
      purchaseTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_time'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
    );
  }

  @override
  $PurchaseLogsTable createAlias(String alias) {
    return $PurchaseLogsTable(attachedDatabase, alias);
  }
}

class PurchaseLog extends DataClass implements Insertable<PurchaseLog> {
  final int id;
  final int studentId;
  final int? coursePackId;
  final String courseName;
  final double amount;
  final double lessons;
  final DateTime purchaseTime;
  final String? remarks;
  const PurchaseLog({
    required this.id,
    required this.studentId,
    this.coursePackId,
    required this.courseName,
    required this.amount,
    required this.lessons,
    required this.purchaseTime,
    this.remarks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    if (!nullToAbsent || coursePackId != null) {
      map['course_pack_id'] = Variable<int>(coursePackId);
    }
    map['course_name'] = Variable<String>(courseName);
    map['amount'] = Variable<double>(amount);
    map['lessons'] = Variable<double>(lessons);
    map['purchase_time'] = Variable<DateTime>(purchaseTime);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    return map;
  }

  PurchaseLogsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseLogsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      coursePackId: coursePackId == null && nullToAbsent
          ? const Value.absent()
          : Value(coursePackId),
      courseName: Value(courseName),
      amount: Value(amount),
      lessons: Value(lessons),
      purchaseTime: Value(purchaseTime),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
    );
  }

  factory PurchaseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseLog(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      coursePackId: serializer.fromJson<int?>(json['coursePackId']),
      courseName: serializer.fromJson<String>(json['courseName']),
      amount: serializer.fromJson<double>(json['amount']),
      lessons: serializer.fromJson<double>(json['lessons']),
      purchaseTime: serializer.fromJson<DateTime>(json['purchaseTime']),
      remarks: serializer.fromJson<String?>(json['remarks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'coursePackId': serializer.toJson<int?>(coursePackId),
      'courseName': serializer.toJson<String>(courseName),
      'amount': serializer.toJson<double>(amount),
      'lessons': serializer.toJson<double>(lessons),
      'purchaseTime': serializer.toJson<DateTime>(purchaseTime),
      'remarks': serializer.toJson<String?>(remarks),
    };
  }

  PurchaseLog copyWith({
    int? id,
    int? studentId,
    Value<int?> coursePackId = const Value.absent(),
    String? courseName,
    double? amount,
    double? lessons,
    DateTime? purchaseTime,
    Value<String?> remarks = const Value.absent(),
  }) => PurchaseLog(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    coursePackId: coursePackId.present ? coursePackId.value : this.coursePackId,
    courseName: courseName ?? this.courseName,
    amount: amount ?? this.amount,
    lessons: lessons ?? this.lessons,
    purchaseTime: purchaseTime ?? this.purchaseTime,
    remarks: remarks.present ? remarks.value : this.remarks,
  );
  PurchaseLog copyWithCompanion(PurchaseLogsCompanion data) {
    return PurchaseLog(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      coursePackId: data.coursePackId.present
          ? data.coursePackId.value
          : this.coursePackId,
      courseName: data.courseName.present
          ? data.courseName.value
          : this.courseName,
      amount: data.amount.present ? data.amount.value : this.amount,
      lessons: data.lessons.present ? data.lessons.value : this.lessons,
      purchaseTime: data.purchaseTime.present
          ? data.purchaseTime.value
          : this.purchaseTime,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseLog(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseName: $courseName, ')
          ..write('amount: $amount, ')
          ..write('lessons: $lessons, ')
          ..write('purchaseTime: $purchaseTime, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    coursePackId,
    courseName,
    amount,
    lessons,
    purchaseTime,
    remarks,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseLog &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.coursePackId == this.coursePackId &&
          other.courseName == this.courseName &&
          other.amount == this.amount &&
          other.lessons == this.lessons &&
          other.purchaseTime == this.purchaseTime &&
          other.remarks == this.remarks);
}

class PurchaseLogsCompanion extends UpdateCompanion<PurchaseLog> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int?> coursePackId;
  final Value<String> courseName;
  final Value<double> amount;
  final Value<double> lessons;
  final Value<DateTime> purchaseTime;
  final Value<String?> remarks;
  const PurchaseLogsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.coursePackId = const Value.absent(),
    this.courseName = const Value.absent(),
    this.amount = const Value.absent(),
    this.lessons = const Value.absent(),
    this.purchaseTime = const Value.absent(),
    this.remarks = const Value.absent(),
  });
  PurchaseLogsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    this.coursePackId = const Value.absent(),
    required String courseName,
    required double amount,
    required double lessons,
    this.purchaseTime = const Value.absent(),
    this.remarks = const Value.absent(),
  }) : studentId = Value(studentId),
       courseName = Value(courseName),
       amount = Value(amount),
       lessons = Value(lessons);
  static Insertable<PurchaseLog> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? coursePackId,
    Expression<String>? courseName,
    Expression<double>? amount,
    Expression<double>? lessons,
    Expression<DateTime>? purchaseTime,
    Expression<String>? remarks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (coursePackId != null) 'course_pack_id': coursePackId,
      if (courseName != null) 'course_name': courseName,
      if (amount != null) 'amount': amount,
      if (lessons != null) 'lessons': lessons,
      if (purchaseTime != null) 'purchase_time': purchaseTime,
      if (remarks != null) 'remarks': remarks,
    });
  }

  PurchaseLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int?>? coursePackId,
    Value<String>? courseName,
    Value<double>? amount,
    Value<double>? lessons,
    Value<DateTime>? purchaseTime,
    Value<String?>? remarks,
  }) {
    return PurchaseLogsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      coursePackId: coursePackId ?? this.coursePackId,
      courseName: courseName ?? this.courseName,
      amount: amount ?? this.amount,
      lessons: lessons ?? this.lessons,
      purchaseTime: purchaseTime ?? this.purchaseTime,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (coursePackId.present) {
      map['course_pack_id'] = Variable<int>(coursePackId.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (lessons.present) {
      map['lessons'] = Variable<double>(lessons.value);
    }
    if (purchaseTime.present) {
      map['purchase_time'] = Variable<DateTime>(purchaseTime.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseLogsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('coursePackId: $coursePackId, ')
          ..write('courseName: $courseName, ')
          ..write('amount: $amount, ')
          ..write('lessons: $lessons, ')
          ..write('purchaseTime: $purchaseTime, ')
          ..write('remarks: $remarks')
          ..write(')'))
        .toString();
  }
}

class $CourseTypesTable extends CourseTypes
    with TableInfo<$CourseTypesTable, CourseType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $CourseTypesTable createAlias(String alias) {
    return $CourseTypesTable(attachedDatabase, alias);
  }
}

class CourseType extends DataClass implements Insertable<CourseType> {
  final int id;
  final String name;
  const CourseType({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CourseTypesCompanion toCompanion(bool nullToAbsent) {
    return CourseTypesCompanion(id: Value(id), name: Value(name));
  }

  factory CourseType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseType(
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

  CourseType copyWith({int? id, String? name}) =>
      CourseType(id: id ?? this.id, name: name ?? this.name);
  CourseType copyWithCompanion(CourseTypesCompanion data) {
    return CourseType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseType(')
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
      (other is CourseType && other.id == this.id && other.name == this.name);
}

class CourseTypesCompanion extends UpdateCompanion<CourseType> {
  final Value<int> id;
  final Value<String> name;
  const CourseTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CourseTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<CourseType> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CourseTypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CourseTypesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $StudentCourseTypeDebtsTable extends StudentCourseTypeDebts
    with TableInfo<$StudentCourseTypeDebtsTable, StudentCourseTypeDebt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentCourseTypeDebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseTypeIdMeta = const VerificationMeta(
    'courseTypeId',
  );
  @override
  late final GeneratedColumn<int> courseTypeId = GeneratedColumn<int>(
    'course_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debtAmountMeta = const VerificationMeta(
    'debtAmount',
  );
  @override
  late final GeneratedColumn<double> debtAmount = GeneratedColumn<double>(
    'debt_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    courseTypeId,
    debtAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_course_type_debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentCourseTypeDebt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_type_id')) {
      context.handle(
        _courseTypeIdMeta,
        courseTypeId.isAcceptableOrUnknown(
          data['course_type_id']!,
          _courseTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseTypeIdMeta);
    }
    if (data.containsKey('debt_amount')) {
      context.handle(
        _debtAmountMeta,
        debtAmount.isAcceptableOrUnknown(data['debt_amount']!, _debtAmountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentCourseTypeDebt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentCourseTypeDebt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      courseTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_type_id'],
      )!,
      debtAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}debt_amount'],
      )!,
    );
  }

  @override
  $StudentCourseTypeDebtsTable createAlias(String alias) {
    return $StudentCourseTypeDebtsTable(attachedDatabase, alias);
  }
}

class StudentCourseTypeDebt extends DataClass
    implements Insertable<StudentCourseTypeDebt> {
  final int id;
  final int studentId;
  final int courseTypeId;
  final double debtAmount;
  const StudentCourseTypeDebt({
    required this.id,
    required this.studentId,
    required this.courseTypeId,
    required this.debtAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['course_type_id'] = Variable<int>(courseTypeId);
    map['debt_amount'] = Variable<double>(debtAmount);
    return map;
  }

  StudentCourseTypeDebtsCompanion toCompanion(bool nullToAbsent) {
    return StudentCourseTypeDebtsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      courseTypeId: Value(courseTypeId),
      debtAmount: Value(debtAmount),
    );
  }

  factory StudentCourseTypeDebt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentCourseTypeDebt(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      courseTypeId: serializer.fromJson<int>(json['courseTypeId']),
      debtAmount: serializer.fromJson<double>(json['debtAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'courseTypeId': serializer.toJson<int>(courseTypeId),
      'debtAmount': serializer.toJson<double>(debtAmount),
    };
  }

  StudentCourseTypeDebt copyWith({
    int? id,
    int? studentId,
    int? courseTypeId,
    double? debtAmount,
  }) => StudentCourseTypeDebt(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    courseTypeId: courseTypeId ?? this.courseTypeId,
    debtAmount: debtAmount ?? this.debtAmount,
  );
  StudentCourseTypeDebt copyWithCompanion(
    StudentCourseTypeDebtsCompanion data,
  ) {
    return StudentCourseTypeDebt(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      courseTypeId: data.courseTypeId.present
          ? data.courseTypeId.value
          : this.courseTypeId,
      debtAmount: data.debtAmount.present
          ? data.debtAmount.value
          : this.debtAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentCourseTypeDebt(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('debtAmount: $debtAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, studentId, courseTypeId, debtAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentCourseTypeDebt &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.courseTypeId == this.courseTypeId &&
          other.debtAmount == this.debtAmount);
}

class StudentCourseTypeDebtsCompanion
    extends UpdateCompanion<StudentCourseTypeDebt> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> courseTypeId;
  final Value<double> debtAmount;
  const StudentCourseTypeDebtsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    this.debtAmount = const Value.absent(),
  });
  StudentCourseTypeDebtsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int courseTypeId,
    this.debtAmount = const Value.absent(),
  }) : studentId = Value(studentId),
       courseTypeId = Value(courseTypeId);
  static Insertable<StudentCourseTypeDebt> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? courseTypeId,
    Expression<double>? debtAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (courseTypeId != null) 'course_type_id': courseTypeId,
      if (debtAmount != null) 'debt_amount': debtAmount,
    });
  }

  StudentCourseTypeDebtsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? courseTypeId,
    Value<double>? debtAmount,
  }) {
    return StudentCourseTypeDebtsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseTypeId: courseTypeId ?? this.courseTypeId,
      debtAmount: debtAmount ?? this.debtAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (courseTypeId.present) {
      map['course_type_id'] = Variable<int>(courseTypeId.value);
    }
    if (debtAmount.present) {
      map['debt_amount'] = Variable<double>(debtAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentCourseTypeDebtsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('debtAmount: $debtAmount')
          ..write(')'))
        .toString();
  }
}

class $StudentCourseTypePricesTable extends StudentCourseTypePrices
    with TableInfo<$StudentCourseTypePricesTable, StudentCourseTypePrice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentCourseTypePricesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseTypeIdMeta = const VerificationMeta(
    'courseTypeId',
  );
  @override
  late final GeneratedColumn<int> courseTypeId = GeneratedColumn<int>(
    'course_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, studentId, courseTypeId, price];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_course_type_prices';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentCourseTypePrice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_type_id')) {
      context.handle(
        _courseTypeIdMeta,
        courseTypeId.isAcceptableOrUnknown(
          data['course_type_id']!,
          _courseTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseTypeIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentCourseTypePrice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentCourseTypePrice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      courseTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_type_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $StudentCourseTypePricesTable createAlias(String alias) {
    return $StudentCourseTypePricesTable(attachedDatabase, alias);
  }
}

class StudentCourseTypePrice extends DataClass
    implements Insertable<StudentCourseTypePrice> {
  final int id;
  final int studentId;
  final int courseTypeId;
  final double price;
  const StudentCourseTypePrice({
    required this.id,
    required this.studentId,
    required this.courseTypeId,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['course_type_id'] = Variable<int>(courseTypeId);
    map['price'] = Variable<double>(price);
    return map;
  }

  StudentCourseTypePricesCompanion toCompanion(bool nullToAbsent) {
    return StudentCourseTypePricesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      courseTypeId: Value(courseTypeId),
      price: Value(price),
    );
  }

  factory StudentCourseTypePrice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentCourseTypePrice(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      courseTypeId: serializer.fromJson<int>(json['courseTypeId']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'courseTypeId': serializer.toJson<int>(courseTypeId),
      'price': serializer.toJson<double>(price),
    };
  }

  StudentCourseTypePrice copyWith({
    int? id,
    int? studentId,
    int? courseTypeId,
    double? price,
  }) => StudentCourseTypePrice(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    courseTypeId: courseTypeId ?? this.courseTypeId,
    price: price ?? this.price,
  );
  StudentCourseTypePrice copyWithCompanion(
    StudentCourseTypePricesCompanion data,
  ) {
    return StudentCourseTypePrice(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      courseTypeId: data.courseTypeId.present
          ? data.courseTypeId.value
          : this.courseTypeId,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentCourseTypePrice(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, studentId, courseTypeId, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentCourseTypePrice &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.courseTypeId == this.courseTypeId &&
          other.price == this.price);
}

class StudentCourseTypePricesCompanion
    extends UpdateCompanion<StudentCourseTypePrice> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> courseTypeId;
  final Value<double> price;
  const StudentCourseTypePricesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.courseTypeId = const Value.absent(),
    this.price = const Value.absent(),
  });
  StudentCourseTypePricesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int courseTypeId,
    required double price,
  }) : studentId = Value(studentId),
       courseTypeId = Value(courseTypeId),
       price = Value(price);
  static Insertable<StudentCourseTypePrice> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? courseTypeId,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (courseTypeId != null) 'course_type_id': courseTypeId,
      if (price != null) 'price': price,
    });
  }

  StudentCourseTypePricesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? courseTypeId,
    Value<double>? price,
  }) {
    return StudentCourseTypePricesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseTypeId: courseTypeId ?? this.courseTypeId,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (courseTypeId.present) {
      map['course_type_id'] = Variable<int>(courseTypeId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentCourseTypePricesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseTypeId: $courseTypeId, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $CoursePacksTable coursePacks = $CoursePacksTable(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $CheckInLogsTable checkInLogs = $CheckInLogsTable(this);
  late final $RefundLogsTable refundLogs = $RefundLogsTable(this);
  late final $PurchaseLogsTable purchaseLogs = $PurchaseLogsTable(this);
  late final $CourseTypesTable courseTypes = $CourseTypesTable(this);
  late final $StudentCourseTypeDebtsTable studentCourseTypeDebts =
      $StudentCourseTypeDebtsTable(this);
  late final $StudentCourseTypePricesTable studentCourseTypePrices =
      $StudentCourseTypePricesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    students,
    coursePacks,
    schedules,
    checkInLogs,
    refundLogs,
    purchaseLogs,
    courseTypes,
    studentCourseTypeDebts,
    studentCourseTypePrices,
  ];
}

typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
      Value<bool> isSuspended,
      Value<double> initialAccumulatedLessons,
      Value<double?> payPerLessonPrice,
      Value<bool> isTrial,
      Value<double> overUsageLessons,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<DateTime> createdAt,
      Value<bool> isArchived,
      Value<bool> isSuspended,
      Value<double> initialAccumulatedLessons,
      Value<double?> payPerLessonPrice,
      Value<bool> isTrial,
      Value<double> overUsageLessons,
    });

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSuspended => $composableBuilder(
    column: $table.isSuspended,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get payPerLessonPrice => $composableBuilder(
    column: $table.payPerLessonPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTrial => $composableBuilder(
    column: $table.isTrial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get overUsageLessons => $composableBuilder(
    column: $table.overUsageLessons,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSuspended => $composableBuilder(
    column: $table.isSuspended,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get payPerLessonPrice => $composableBuilder(
    column: $table.payPerLessonPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTrial => $composableBuilder(
    column: $table.isTrial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get overUsageLessons => $composableBuilder(
    column: $table.overUsageLessons,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSuspended => $composableBuilder(
    column: $table.isSuspended,
    builder: (column) => column,
  );

  GeneratedColumn<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => column,
  );

  GeneratedColumn<double> get payPerLessonPrice => $composableBuilder(
    column: $table.payPerLessonPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTrial =>
      $composableBuilder(column: $table.isTrial, builder: (column) => column);

  GeneratedColumn<double> get overUsageLessons => $composableBuilder(
    column: $table.overUsageLessons,
    builder: (column) => column,
  );
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
          Student,
          PrefetchHooks Function()
        > {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSuspended = const Value.absent(),
                Value<double> initialAccumulatedLessons = const Value.absent(),
                Value<double?> payPerLessonPrice = const Value.absent(),
                Value<bool> isTrial = const Value.absent(),
                Value<double> overUsageLessons = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                name: name,
                phone: phone,
                createdAt: createdAt,
                isArchived: isArchived,
                isSuspended: isSuspended,
                initialAccumulatedLessons: initialAccumulatedLessons,
                payPerLessonPrice: payPerLessonPrice,
                isTrial: isTrial,
                overUsageLessons: overUsageLessons,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSuspended = const Value.absent(),
                Value<double> initialAccumulatedLessons = const Value.absent(),
                Value<double?> payPerLessonPrice = const Value.absent(),
                Value<bool> isTrial = const Value.absent(),
                Value<double> overUsageLessons = const Value.absent(),
              }) => StudentsCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                createdAt: createdAt,
                isArchived: isArchived,
                isSuspended: isSuspended,
                initialAccumulatedLessons: initialAccumulatedLessons,
                payPerLessonPrice: payPerLessonPrice,
                isTrial: isTrial,
                overUsageLessons: overUsageLessons,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
      Student,
      PrefetchHooks Function()
    >;
typedef $$CoursePacksTableCreateCompanionBuilder =
    CoursePacksCompanion Function({
      Value<int> id,
      required int studentId,
      Value<int?> courseTypeId,
      required String courseName,
      required double totalLessons,
      required double remainingLessons,
      required double unitPrice,
      Value<double> initialAccumulatedLessons,
    });
typedef $$CoursePacksTableUpdateCompanionBuilder =
    CoursePacksCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int?> courseTypeId,
      Value<String> courseName,
      Value<double> totalLessons,
      Value<double> remainingLessons,
      Value<double> unitPrice,
      Value<double> initialAccumulatedLessons,
    });

class $$CoursePacksTableFilterComposer
    extends Composer<_$AppDatabase, $CoursePacksTable> {
  $$CoursePacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalLessons => $composableBuilder(
    column: $table.totalLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingLessons => $composableBuilder(
    column: $table.remainingLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoursePacksTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursePacksTable> {
  $$CoursePacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalLessons => $composableBuilder(
    column: $table.totalLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingLessons => $composableBuilder(
    column: $table.remainingLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursePacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursePacksTable> {
  $$CoursePacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalLessons => $composableBuilder(
    column: $table.totalLessons,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingLessons => $composableBuilder(
    column: $table.remainingLessons,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get initialAccumulatedLessons => $composableBuilder(
    column: $table.initialAccumulatedLessons,
    builder: (column) => column,
  );
}

class $$CoursePacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursePacksTable,
          CoursePack,
          $$CoursePacksTableFilterComposer,
          $$CoursePacksTableOrderingComposer,
          $$CoursePacksTableAnnotationComposer,
          $$CoursePacksTableCreateCompanionBuilder,
          $$CoursePacksTableUpdateCompanionBuilder,
          (
            CoursePack,
            BaseReferences<_$AppDatabase, $CoursePacksTable, CoursePack>,
          ),
          CoursePack,
          PrefetchHooks Function()
        > {
  $$CoursePacksTableTableManager(_$AppDatabase db, $CoursePacksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursePacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursePacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursePacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> courseTypeId = const Value.absent(),
                Value<String> courseName = const Value.absent(),
                Value<double> totalLessons = const Value.absent(),
                Value<double> remainingLessons = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> initialAccumulatedLessons = const Value.absent(),
              }) => CoursePacksCompanion(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                courseName: courseName,
                totalLessons: totalLessons,
                remainingLessons: remainingLessons,
                unitPrice: unitPrice,
                initialAccumulatedLessons: initialAccumulatedLessons,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                Value<int?> courseTypeId = const Value.absent(),
                required String courseName,
                required double totalLessons,
                required double remainingLessons,
                required double unitPrice,
                Value<double> initialAccumulatedLessons = const Value.absent(),
              }) => CoursePacksCompanion.insert(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                courseName: courseName,
                totalLessons: totalLessons,
                remainingLessons: remainingLessons,
                unitPrice: unitPrice,
                initialAccumulatedLessons: initialAccumulatedLessons,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoursePacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursePacksTable,
      CoursePack,
      $$CoursePacksTableFilterComposer,
      $$CoursePacksTableOrderingComposer,
      $$CoursePacksTableAnnotationComposer,
      $$CoursePacksTableCreateCompanionBuilder,
      $$CoursePacksTableUpdateCompanionBuilder,
      (
        CoursePack,
        BaseReferences<_$AppDatabase, $CoursePacksTable, CoursePack>,
      ),
      CoursePack,
      PrefetchHooks Function()
    >;
typedef $$SchedulesTableCreateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      required int studentId,
      Value<int?> coursePackId,
      Value<int?> courseTypeId,
      required DateTime startTime,
      required DateTime endTime,
      Value<double> lessonDeduction,
      Value<ScheduleStatus> status,
      Value<String?> systemEventId,
      Value<String?> recurringGroupId,
    });
typedef $$SchedulesTableUpdateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int?> coursePackId,
      Value<int?> courseTypeId,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<double> lessonDeduction,
      Value<ScheduleStatus> status,
      Value<String?> systemEventId,
      Value<String?> recurringGroupId,
    });

class $$SchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lessonDeduction => $composableBuilder(
    column: $table.lessonDeduction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ScheduleStatus, ScheduleStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get systemEventId => $composableBuilder(
    column: $table.systemEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurringGroupId => $composableBuilder(
    column: $table.recurringGroupId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lessonDeduction => $composableBuilder(
    column: $table.lessonDeduction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemEventId => $composableBuilder(
    column: $table.systemEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurringGroupId => $composableBuilder(
    column: $table.recurringGroupId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<double> get lessonDeduction => $composableBuilder(
    column: $table.lessonDeduction,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ScheduleStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get systemEventId => $composableBuilder(
    column: $table.systemEventId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurringGroupId => $composableBuilder(
    column: $table.recurringGroupId,
    builder: (column) => column,
  );
}

class $$SchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchedulesTable,
          Schedule,
          $$SchedulesTableFilterComposer,
          $$SchedulesTableOrderingComposer,
          $$SchedulesTableAnnotationComposer,
          $$SchedulesTableCreateCompanionBuilder,
          $$SchedulesTableUpdateCompanionBuilder,
          (Schedule, BaseReferences<_$AppDatabase, $SchedulesTable, Schedule>),
          Schedule,
          PrefetchHooks Function()
        > {
  $$SchedulesTableTableManager(_$AppDatabase db, $SchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> coursePackId = const Value.absent(),
                Value<int?> courseTypeId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<double> lessonDeduction = const Value.absent(),
                Value<ScheduleStatus> status = const Value.absent(),
                Value<String?> systemEventId = const Value.absent(),
                Value<String?> recurringGroupId = const Value.absent(),
              }) => SchedulesCompanion(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                courseTypeId: courseTypeId,
                startTime: startTime,
                endTime: endTime,
                lessonDeduction: lessonDeduction,
                status: status,
                systemEventId: systemEventId,
                recurringGroupId: recurringGroupId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                Value<int?> coursePackId = const Value.absent(),
                Value<int?> courseTypeId = const Value.absent(),
                required DateTime startTime,
                required DateTime endTime,
                Value<double> lessonDeduction = const Value.absent(),
                Value<ScheduleStatus> status = const Value.absent(),
                Value<String?> systemEventId = const Value.absent(),
                Value<String?> recurringGroupId = const Value.absent(),
              }) => SchedulesCompanion.insert(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                courseTypeId: courseTypeId,
                startTime: startTime,
                endTime: endTime,
                lessonDeduction: lessonDeduction,
                status: status,
                systemEventId: systemEventId,
                recurringGroupId: recurringGroupId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchedulesTable,
      Schedule,
      $$SchedulesTableFilterComposer,
      $$SchedulesTableOrderingComposer,
      $$SchedulesTableAnnotationComposer,
      $$SchedulesTableCreateCompanionBuilder,
      $$SchedulesTableUpdateCompanionBuilder,
      (Schedule, BaseReferences<_$AppDatabase, $SchedulesTable, Schedule>),
      Schedule,
      PrefetchHooks Function()
    >;
typedef $$CheckInLogsTableCreateCompanionBuilder =
    CheckInLogsCompanion Function({
      Value<int> id,
      Value<int?> scheduleId,
      required int studentId,
      Value<int?> coursePackId,
      Value<int?> courseTypeId,
      required double deductedLessons,
      Value<DateTime> checkInTime,
      Value<String?> remarks,
      Value<double> paymentAmount,
    });
typedef $$CheckInLogsTableUpdateCompanionBuilder =
    CheckInLogsCompanion Function({
      Value<int> id,
      Value<int?> scheduleId,
      Value<int> studentId,
      Value<int?> coursePackId,
      Value<int?> courseTypeId,
      Value<double> deductedLessons,
      Value<DateTime> checkInTime,
      Value<String?> remarks,
      Value<double> paymentAmount,
    });

class $$CheckInLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInLogsTable> {
  $$CheckInLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleId => $composableBuilder(
    column: $table.scheduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckInLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInLogsTable> {
  $$CheckInLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleId => $composableBuilder(
    column: $table.scheduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckInLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInLogsTable> {
  $$CheckInLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get scheduleId => $composableBuilder(
    column: $table.scheduleId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => column,
  );
}

class $$CheckInLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInLogsTable,
          CheckInLog,
          $$CheckInLogsTableFilterComposer,
          $$CheckInLogsTableOrderingComposer,
          $$CheckInLogsTableAnnotationComposer,
          $$CheckInLogsTableCreateCompanionBuilder,
          $$CheckInLogsTableUpdateCompanionBuilder,
          (
            CheckInLog,
            BaseReferences<_$AppDatabase, $CheckInLogsTable, CheckInLog>,
          ),
          CheckInLog,
          PrefetchHooks Function()
        > {
  $$CheckInLogsTableTableManager(_$AppDatabase db, $CheckInLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduleId = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> coursePackId = const Value.absent(),
                Value<int?> courseTypeId = const Value.absent(),
                Value<double> deductedLessons = const Value.absent(),
                Value<DateTime> checkInTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<double> paymentAmount = const Value.absent(),
              }) => CheckInLogsCompanion(
                id: id,
                scheduleId: scheduleId,
                studentId: studentId,
                coursePackId: coursePackId,
                courseTypeId: courseTypeId,
                deductedLessons: deductedLessons,
                checkInTime: checkInTime,
                remarks: remarks,
                paymentAmount: paymentAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduleId = const Value.absent(),
                required int studentId,
                Value<int?> coursePackId = const Value.absent(),
                Value<int?> courseTypeId = const Value.absent(),
                required double deductedLessons,
                Value<DateTime> checkInTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<double> paymentAmount = const Value.absent(),
              }) => CheckInLogsCompanion.insert(
                id: id,
                scheduleId: scheduleId,
                studentId: studentId,
                coursePackId: coursePackId,
                courseTypeId: courseTypeId,
                deductedLessons: deductedLessons,
                checkInTime: checkInTime,
                remarks: remarks,
                paymentAmount: paymentAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckInLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInLogsTable,
      CheckInLog,
      $$CheckInLogsTableFilterComposer,
      $$CheckInLogsTableOrderingComposer,
      $$CheckInLogsTableAnnotationComposer,
      $$CheckInLogsTableCreateCompanionBuilder,
      $$CheckInLogsTableUpdateCompanionBuilder,
      (
        CheckInLog,
        BaseReferences<_$AppDatabase, $CheckInLogsTable, CheckInLog>,
      ),
      CheckInLog,
      PrefetchHooks Function()
    >;
typedef $$RefundLogsTableCreateCompanionBuilder =
    RefundLogsCompanion Function({
      Value<int> id,
      required int studentId,
      required int coursePackId,
      required double refundAmount,
      required double deductedLessons,
      Value<DateTime> refundTime,
      Value<String?> remarks,
    });
typedef $$RefundLogsTableUpdateCompanionBuilder =
    RefundLogsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> coursePackId,
      Value<double> refundAmount,
      Value<double> deductedLessons,
      Value<DateTime> refundTime,
      Value<String?> remarks,
    });

class $$RefundLogsTableFilterComposer
    extends Composer<_$AppDatabase, $RefundLogsTable> {
  $$RefundLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get refundTime => $composableBuilder(
    column: $table.refundTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RefundLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $RefundLogsTable> {
  $$RefundLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get refundTime => $composableBuilder(
    column: $table.refundTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RefundLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RefundLogsTable> {
  $$RefundLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get deductedLessons => $composableBuilder(
    column: $table.deductedLessons,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get refundTime => $composableBuilder(
    column: $table.refundTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);
}

class $$RefundLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RefundLogsTable,
          RefundLog,
          $$RefundLogsTableFilterComposer,
          $$RefundLogsTableOrderingComposer,
          $$RefundLogsTableAnnotationComposer,
          $$RefundLogsTableCreateCompanionBuilder,
          $$RefundLogsTableUpdateCompanionBuilder,
          (
            RefundLog,
            BaseReferences<_$AppDatabase, $RefundLogsTable, RefundLog>,
          ),
          RefundLog,
          PrefetchHooks Function()
        > {
  $$RefundLogsTableTableManager(_$AppDatabase db, $RefundLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RefundLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RefundLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RefundLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> coursePackId = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<double> deductedLessons = const Value.absent(),
                Value<DateTime> refundTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => RefundLogsCompanion(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                refundAmount: refundAmount,
                deductedLessons: deductedLessons,
                refundTime: refundTime,
                remarks: remarks,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int coursePackId,
                required double refundAmount,
                required double deductedLessons,
                Value<DateTime> refundTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => RefundLogsCompanion.insert(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                refundAmount: refundAmount,
                deductedLessons: deductedLessons,
                refundTime: refundTime,
                remarks: remarks,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RefundLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RefundLogsTable,
      RefundLog,
      $$RefundLogsTableFilterComposer,
      $$RefundLogsTableOrderingComposer,
      $$RefundLogsTableAnnotationComposer,
      $$RefundLogsTableCreateCompanionBuilder,
      $$RefundLogsTableUpdateCompanionBuilder,
      (RefundLog, BaseReferences<_$AppDatabase, $RefundLogsTable, RefundLog>),
      RefundLog,
      PrefetchHooks Function()
    >;
typedef $$PurchaseLogsTableCreateCompanionBuilder =
    PurchaseLogsCompanion Function({
      Value<int> id,
      required int studentId,
      Value<int?> coursePackId,
      required String courseName,
      required double amount,
      required double lessons,
      Value<DateTime> purchaseTime,
      Value<String?> remarks,
    });
typedef $$PurchaseLogsTableUpdateCompanionBuilder =
    PurchaseLogsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int?> coursePackId,
      Value<String> courseName,
      Value<double> amount,
      Value<double> lessons,
      Value<DateTime> purchaseTime,
      Value<String?> remarks,
    });

class $$PurchaseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseLogsTable> {
  $$PurchaseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseTime => $composableBuilder(
    column: $table.purchaseTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseLogsTable> {
  $$PurchaseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseTime => $composableBuilder(
    column: $table.purchaseTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseLogsTable> {
  $$PurchaseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get coursePackId => $composableBuilder(
    column: $table.coursePackId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get lessons =>
      $composableBuilder(column: $table.lessons, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseTime => $composableBuilder(
    column: $table.purchaseTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);
}

class $$PurchaseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseLogsTable,
          PurchaseLog,
          $$PurchaseLogsTableFilterComposer,
          $$PurchaseLogsTableOrderingComposer,
          $$PurchaseLogsTableAnnotationComposer,
          $$PurchaseLogsTableCreateCompanionBuilder,
          $$PurchaseLogsTableUpdateCompanionBuilder,
          (
            PurchaseLog,
            BaseReferences<_$AppDatabase, $PurchaseLogsTable, PurchaseLog>,
          ),
          PurchaseLog,
          PrefetchHooks Function()
        > {
  $$PurchaseLogsTableTableManager(_$AppDatabase db, $PurchaseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int?> coursePackId = const Value.absent(),
                Value<String> courseName = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> lessons = const Value.absent(),
                Value<DateTime> purchaseTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => PurchaseLogsCompanion(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                courseName: courseName,
                amount: amount,
                lessons: lessons,
                purchaseTime: purchaseTime,
                remarks: remarks,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                Value<int?> coursePackId = const Value.absent(),
                required String courseName,
                required double amount,
                required double lessons,
                Value<DateTime> purchaseTime = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
              }) => PurchaseLogsCompanion.insert(
                id: id,
                studentId: studentId,
                coursePackId: coursePackId,
                courseName: courseName,
                amount: amount,
                lessons: lessons,
                purchaseTime: purchaseTime,
                remarks: remarks,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseLogsTable,
      PurchaseLog,
      $$PurchaseLogsTableFilterComposer,
      $$PurchaseLogsTableOrderingComposer,
      $$PurchaseLogsTableAnnotationComposer,
      $$PurchaseLogsTableCreateCompanionBuilder,
      $$PurchaseLogsTableUpdateCompanionBuilder,
      (
        PurchaseLog,
        BaseReferences<_$AppDatabase, $PurchaseLogsTable, PurchaseLog>,
      ),
      PurchaseLog,
      PrefetchHooks Function()
    >;
typedef $$CourseTypesTableCreateCompanionBuilder =
    CourseTypesCompanion Function({Value<int> id, required String name});
typedef $$CourseTypesTableUpdateCompanionBuilder =
    CourseTypesCompanion Function({Value<int> id, Value<String> name});

class $$CourseTypesTableFilterComposer
    extends Composer<_$AppDatabase, $CourseTypesTable> {
  $$CourseTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CourseTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseTypesTable> {
  $$CourseTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CourseTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseTypesTable> {
  $$CourseTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$CourseTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseTypesTable,
          CourseType,
          $$CourseTypesTableFilterComposer,
          $$CourseTypesTableOrderingComposer,
          $$CourseTypesTableAnnotationComposer,
          $$CourseTypesTableCreateCompanionBuilder,
          $$CourseTypesTableUpdateCompanionBuilder,
          (
            CourseType,
            BaseReferences<_$AppDatabase, $CourseTypesTable, CourseType>,
          ),
          CourseType,
          PrefetchHooks Function()
        > {
  $$CourseTypesTableTableManager(_$AppDatabase db, $CourseTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourseTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourseTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CourseTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => CourseTypesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  CourseTypesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CourseTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseTypesTable,
      CourseType,
      $$CourseTypesTableFilterComposer,
      $$CourseTypesTableOrderingComposer,
      $$CourseTypesTableAnnotationComposer,
      $$CourseTypesTableCreateCompanionBuilder,
      $$CourseTypesTableUpdateCompanionBuilder,
      (
        CourseType,
        BaseReferences<_$AppDatabase, $CourseTypesTable, CourseType>,
      ),
      CourseType,
      PrefetchHooks Function()
    >;
typedef $$StudentCourseTypeDebtsTableCreateCompanionBuilder =
    StudentCourseTypeDebtsCompanion Function({
      Value<int> id,
      required int studentId,
      required int courseTypeId,
      Value<double> debtAmount,
    });
typedef $$StudentCourseTypeDebtsTableUpdateCompanionBuilder =
    StudentCourseTypeDebtsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> courseTypeId,
      Value<double> debtAmount,
    });

class $$StudentCourseTypeDebtsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentCourseTypeDebtsTable> {
  $$StudentCourseTypeDebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get debtAmount => $composableBuilder(
    column: $table.debtAmount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentCourseTypeDebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentCourseTypeDebtsTable> {
  $$StudentCourseTypeDebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get debtAmount => $composableBuilder(
    column: $table.debtAmount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentCourseTypeDebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentCourseTypeDebtsTable> {
  $$StudentCourseTypeDebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get debtAmount => $composableBuilder(
    column: $table.debtAmount,
    builder: (column) => column,
  );
}

class $$StudentCourseTypeDebtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentCourseTypeDebtsTable,
          StudentCourseTypeDebt,
          $$StudentCourseTypeDebtsTableFilterComposer,
          $$StudentCourseTypeDebtsTableOrderingComposer,
          $$StudentCourseTypeDebtsTableAnnotationComposer,
          $$StudentCourseTypeDebtsTableCreateCompanionBuilder,
          $$StudentCourseTypeDebtsTableUpdateCompanionBuilder,
          (
            StudentCourseTypeDebt,
            BaseReferences<
              _$AppDatabase,
              $StudentCourseTypeDebtsTable,
              StudentCourseTypeDebt
            >,
          ),
          StudentCourseTypeDebt,
          PrefetchHooks Function()
        > {
  $$StudentCourseTypeDebtsTableTableManager(
    _$AppDatabase db,
    $StudentCourseTypeDebtsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentCourseTypeDebtsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudentCourseTypeDebtsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudentCourseTypeDebtsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> courseTypeId = const Value.absent(),
                Value<double> debtAmount = const Value.absent(),
              }) => StudentCourseTypeDebtsCompanion(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                debtAmount: debtAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int courseTypeId,
                Value<double> debtAmount = const Value.absent(),
              }) => StudentCourseTypeDebtsCompanion.insert(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                debtAmount: debtAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentCourseTypeDebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentCourseTypeDebtsTable,
      StudentCourseTypeDebt,
      $$StudentCourseTypeDebtsTableFilterComposer,
      $$StudentCourseTypeDebtsTableOrderingComposer,
      $$StudentCourseTypeDebtsTableAnnotationComposer,
      $$StudentCourseTypeDebtsTableCreateCompanionBuilder,
      $$StudentCourseTypeDebtsTableUpdateCompanionBuilder,
      (
        StudentCourseTypeDebt,
        BaseReferences<
          _$AppDatabase,
          $StudentCourseTypeDebtsTable,
          StudentCourseTypeDebt
        >,
      ),
      StudentCourseTypeDebt,
      PrefetchHooks Function()
    >;
typedef $$StudentCourseTypePricesTableCreateCompanionBuilder =
    StudentCourseTypePricesCompanion Function({
      Value<int> id,
      required int studentId,
      required int courseTypeId,
      required double price,
    });
typedef $$StudentCourseTypePricesTableUpdateCompanionBuilder =
    StudentCourseTypePricesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> courseTypeId,
      Value<double> price,
    });

class $$StudentCourseTypePricesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentCourseTypePricesTable> {
  $$StudentCourseTypePricesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentCourseTypePricesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentCourseTypePricesTable> {
  $$StudentCourseTypePricesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentCourseTypePricesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentCourseTypePricesTable> {
  $$StudentCourseTypePricesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get courseTypeId => $composableBuilder(
    column: $table.courseTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);
}

class $$StudentCourseTypePricesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentCourseTypePricesTable,
          StudentCourseTypePrice,
          $$StudentCourseTypePricesTableFilterComposer,
          $$StudentCourseTypePricesTableOrderingComposer,
          $$StudentCourseTypePricesTableAnnotationComposer,
          $$StudentCourseTypePricesTableCreateCompanionBuilder,
          $$StudentCourseTypePricesTableUpdateCompanionBuilder,
          (
            StudentCourseTypePrice,
            BaseReferences<
              _$AppDatabase,
              $StudentCourseTypePricesTable,
              StudentCourseTypePrice
            >,
          ),
          StudentCourseTypePrice,
          PrefetchHooks Function()
        > {
  $$StudentCourseTypePricesTableTableManager(
    _$AppDatabase db,
    $StudentCourseTypePricesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentCourseTypePricesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudentCourseTypePricesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudentCourseTypePricesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> courseTypeId = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => StudentCourseTypePricesCompanion(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int courseTypeId,
                required double price,
              }) => StudentCourseTypePricesCompanion.insert(
                id: id,
                studentId: studentId,
                courseTypeId: courseTypeId,
                price: price,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentCourseTypePricesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentCourseTypePricesTable,
      StudentCourseTypePrice,
      $$StudentCourseTypePricesTableFilterComposer,
      $$StudentCourseTypePricesTableOrderingComposer,
      $$StudentCourseTypePricesTableAnnotationComposer,
      $$StudentCourseTypePricesTableCreateCompanionBuilder,
      $$StudentCourseTypePricesTableUpdateCompanionBuilder,
      (
        StudentCourseTypePrice,
        BaseReferences<
          _$AppDatabase,
          $StudentCourseTypePricesTable,
          StudentCourseTypePrice
        >,
      ),
      StudentCourseTypePrice,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$CoursePacksTableTableManager get coursePacks =>
      $$CoursePacksTableTableManager(_db, _db.coursePacks);
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
  $$CheckInLogsTableTableManager get checkInLogs =>
      $$CheckInLogsTableTableManager(_db, _db.checkInLogs);
  $$RefundLogsTableTableManager get refundLogs =>
      $$RefundLogsTableTableManager(_db, _db.refundLogs);
  $$PurchaseLogsTableTableManager get purchaseLogs =>
      $$PurchaseLogsTableTableManager(_db, _db.purchaseLogs);
  $$CourseTypesTableTableManager get courseTypes =>
      $$CourseTypesTableTableManager(_db, _db.courseTypes);
  $$StudentCourseTypeDebtsTableTableManager get studentCourseTypeDebts =>
      $$StudentCourseTypeDebtsTableTableManager(
        _db,
        _db.studentCourseTypeDebts,
      );
  $$StudentCourseTypePricesTableTableManager get studentCourseTypePrices =>
      $$StudentCourseTypePricesTableTableManager(
        _db,
        _db.studentCourseTypePrices,
      );
}

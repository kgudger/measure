// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _value1Meta = const VerificationMeta('value1');
  @override
  late final GeneratedColumn<double> value1 = GeneratedColumn<double>(
    'value1',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _value2Meta = const VerificationMeta('value2');
  @override
  late final GeneratedColumn<double> value2 = GeneratedColumn<double>(
    'value2',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _value3Meta = const VerificationMeta('value3');
  @override
  late final GeneratedColumn<double> value3 = GeneratedColumn<double>(
    'value3',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<int> valueType = GeneratedColumn<int>(
    'value_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
    'room',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buildingMeta = const VerificationMeta(
    'building',
  );
  @override
  late final GeneratedColumn<String> building = GeneratedColumn<String>(
    'building',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateCreatedMeta = const VerificationMeta(
    'dateCreated',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
    'date_created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _dateModifiedMeta = const VerificationMeta(
    'dateModified',
  );
  @override
  late final GeneratedColumn<DateTime> dateModified = GeneratedColumn<DateTime>(
    'date_modified',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _gpsLocationMeta = const VerificationMeta(
    'gpsLocation',
  );
  @override
  late final GeneratedColumn<String> gpsLocation = GeneratedColumn<String>(
    'gps_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    value,
    value1,
    value2,
    value3,
    valueType,
    unit,
    notes,
    room,
    building,
    photo,
    dateCreated,
    dateModified,
    gpsLocation,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('value1')) {
      context.handle(
        _value1Meta,
        value1.isAcceptableOrUnknown(data['value1']!, _value1Meta),
      );
    }
    if (data.containsKey('value2')) {
      context.handle(
        _value2Meta,
        value2.isAcceptableOrUnknown(data['value2']!, _value2Meta),
      );
    }
    if (data.containsKey('value3')) {
      context.handle(
        _value3Meta,
        value3.isAcceptableOrUnknown(data['value3']!, _value3Meta),
      );
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_valueTypeMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    } else if (isInserting) {
      context.missing(_roomMeta);
    }
    if (data.containsKey('building')) {
      context.handle(
        _buildingMeta,
        building.isAcceptableOrUnknown(data['building']!, _buildingMeta),
      );
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    if (data.containsKey('date_created')) {
      context.handle(
        _dateCreatedMeta,
        dateCreated.isAcceptableOrUnknown(
          data['date_created']!,
          _dateCreatedMeta,
        ),
      );
    }
    if (data.containsKey('date_modified')) {
      context.handle(
        _dateModifiedMeta,
        dateModified.isAcceptableOrUnknown(
          data['date_modified']!,
          _dateModifiedMeta,
        ),
      );
    }
    if (data.containsKey('gps_location')) {
      context.handle(
        _gpsLocationMeta,
        gpsLocation.isAcceptableOrUnknown(
          data['gps_location']!,
          _gpsLocationMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      value1: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value1'],
      ),
      value2: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value2'],
      ),
      value3: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value3'],
      ),
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value_type'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      )!,
      building: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}building'],
      ),
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
      dateCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_created'],
      )!,
      dateModified: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_modified'],
      )!,
      gpsLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gps_location'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String title;
  final String category;
  final String value;
  final double? value1;
  final double? value2;
  final double? value3;
  final int valueType;
  final String unit;
  final String notes;
  final String room;
  final String? building;
  final String? photo;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String? gpsLocation;
  final String tags;
  const Item({
    required this.id,
    required this.title,
    required this.category,
    required this.value,
    this.value1,
    this.value2,
    this.value3,
    required this.valueType,
    required this.unit,
    required this.notes,
    required this.room,
    this.building,
    this.photo,
    required this.dateCreated,
    required this.dateModified,
    this.gpsLocation,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || value1 != null) {
      map['value1'] = Variable<double>(value1);
    }
    if (!nullToAbsent || value2 != null) {
      map['value2'] = Variable<double>(value2);
    }
    if (!nullToAbsent || value3 != null) {
      map['value3'] = Variable<double>(value3);
    }
    map['value_type'] = Variable<int>(valueType);
    map['unit'] = Variable<String>(unit);
    map['notes'] = Variable<String>(notes);
    map['room'] = Variable<String>(room);
    if (!nullToAbsent || building != null) {
      map['building'] = Variable<String>(building);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['date_modified'] = Variable<DateTime>(dateModified);
    if (!nullToAbsent || gpsLocation != null) {
      map['gps_location'] = Variable<String>(gpsLocation);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      value: Value(value),
      value1: value1 == null && nullToAbsent
          ? const Value.absent()
          : Value(value1),
      value2: value2 == null && nullToAbsent
          ? const Value.absent()
          : Value(value2),
      value3: value3 == null && nullToAbsent
          ? const Value.absent()
          : Value(value3),
      valueType: Value(valueType),
      unit: Value(unit),
      notes: Value(notes),
      room: Value(room),
      building: building == null && nullToAbsent
          ? const Value.absent()
          : Value(building),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
      dateCreated: Value(dateCreated),
      dateModified: Value(dateModified),
      gpsLocation: gpsLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLocation),
      tags: Value(tags),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      value: serializer.fromJson<String>(json['value']),
      value1: serializer.fromJson<double?>(json['value1']),
      value2: serializer.fromJson<double?>(json['value2']),
      value3: serializer.fromJson<double?>(json['value3']),
      valueType: serializer.fromJson<int>(json['valueType']),
      unit: serializer.fromJson<String>(json['unit']),
      notes: serializer.fromJson<String>(json['notes']),
      room: serializer.fromJson<String>(json['room']),
      building: serializer.fromJson<String?>(json['building']),
      photo: serializer.fromJson<String?>(json['photo']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      dateModified: serializer.fromJson<DateTime>(json['dateModified']),
      gpsLocation: serializer.fromJson<String?>(json['gpsLocation']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'value': serializer.toJson<String>(value),
      'value1': serializer.toJson<double?>(value1),
      'value2': serializer.toJson<double?>(value2),
      'value3': serializer.toJson<double?>(value3),
      'valueType': serializer.toJson<int>(valueType),
      'unit': serializer.toJson<String>(unit),
      'notes': serializer.toJson<String>(notes),
      'room': serializer.toJson<String>(room),
      'building': serializer.toJson<String?>(building),
      'photo': serializer.toJson<String?>(photo),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'dateModified': serializer.toJson<DateTime>(dateModified),
      'gpsLocation': serializer.toJson<String?>(gpsLocation),
      'tags': serializer.toJson<String>(tags),
    };
  }

  Item copyWith({
    int? id,
    String? title,
    String? category,
    String? value,
    Value<double?> value1 = const Value.absent(),
    Value<double?> value2 = const Value.absent(),
    Value<double?> value3 = const Value.absent(),
    int? valueType,
    String? unit,
    String? notes,
    String? room,
    Value<String?> building = const Value.absent(),
    Value<String?> photo = const Value.absent(),
    DateTime? dateCreated,
    DateTime? dateModified,
    Value<String?> gpsLocation = const Value.absent(),
    String? tags,
  }) => Item(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    value: value ?? this.value,
    value1: value1.present ? value1.value : this.value1,
    value2: value2.present ? value2.value : this.value2,
    value3: value3.present ? value3.value : this.value3,
    valueType: valueType ?? this.valueType,
    unit: unit ?? this.unit,
    notes: notes ?? this.notes,
    room: room ?? this.room,
    building: building.present ? building.value : this.building,
    photo: photo.present ? photo.value : this.photo,
    dateCreated: dateCreated ?? this.dateCreated,
    dateModified: dateModified ?? this.dateModified,
    gpsLocation: gpsLocation.present ? gpsLocation.value : this.gpsLocation,
    tags: tags ?? this.tags,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      value: data.value.present ? data.value.value : this.value,
      value1: data.value1.present ? data.value1.value : this.value1,
      value2: data.value2.present ? data.value2.value : this.value2,
      value3: data.value3.present ? data.value3.value : this.value3,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      unit: data.unit.present ? data.unit.value : this.unit,
      notes: data.notes.present ? data.notes.value : this.notes,
      room: data.room.present ? data.room.value : this.room,
      building: data.building.present ? data.building.value : this.building,
      photo: data.photo.present ? data.photo.value : this.photo,
      dateCreated: data.dateCreated.present
          ? data.dateCreated.value
          : this.dateCreated,
      dateModified: data.dateModified.present
          ? data.dateModified.value
          : this.dateModified,
      gpsLocation: data.gpsLocation.present
          ? data.gpsLocation.value
          : this.gpsLocation,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('value: $value, ')
          ..write('value1: $value1, ')
          ..write('value2: $value2, ')
          ..write('value3: $value3, ')
          ..write('valueType: $valueType, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('room: $room, ')
          ..write('building: $building, ')
          ..write('photo: $photo, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('dateModified: $dateModified, ')
          ..write('gpsLocation: $gpsLocation, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    category,
    value,
    value1,
    value2,
    value3,
    valueType,
    unit,
    notes,
    room,
    building,
    photo,
    dateCreated,
    dateModified,
    gpsLocation,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.value == this.value &&
          other.value1 == this.value1 &&
          other.value2 == this.value2 &&
          other.value3 == this.value3 &&
          other.valueType == this.valueType &&
          other.unit == this.unit &&
          other.notes == this.notes &&
          other.room == this.room &&
          other.building == this.building &&
          other.photo == this.photo &&
          other.dateCreated == this.dateCreated &&
          other.dateModified == this.dateModified &&
          other.gpsLocation == this.gpsLocation &&
          other.tags == this.tags);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> value;
  final Value<double?> value1;
  final Value<double?> value2;
  final Value<double?> value3;
  final Value<int> valueType;
  final Value<String> unit;
  final Value<String> notes;
  final Value<String> room;
  final Value<String?> building;
  final Value<String?> photo;
  final Value<DateTime> dateCreated;
  final Value<DateTime> dateModified;
  final Value<String?> gpsLocation;
  final Value<String> tags;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.value = const Value.absent(),
    this.value1 = const Value.absent(),
    this.value2 = const Value.absent(),
    this.value3 = const Value.absent(),
    this.valueType = const Value.absent(),
    this.unit = const Value.absent(),
    this.notes = const Value.absent(),
    this.room = const Value.absent(),
    this.building = const Value.absent(),
    this.photo = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.gpsLocation = const Value.absent(),
    this.tags = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required String value,
    this.value1 = const Value.absent(),
    this.value2 = const Value.absent(),
    this.value3 = const Value.absent(),
    required int valueType,
    required String unit,
    required String notes,
    required String room,
    this.building = const Value.absent(),
    this.photo = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.gpsLocation = const Value.absent(),
    required String tags,
  }) : title = Value(title),
       category = Value(category),
       value = Value(value),
       valueType = Value(valueType),
       unit = Value(unit),
       notes = Value(notes),
       room = Value(room),
       tags = Value(tags);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? value,
    Expression<double>? value1,
    Expression<double>? value2,
    Expression<double>? value3,
    Expression<int>? valueType,
    Expression<String>? unit,
    Expression<String>? notes,
    Expression<String>? room,
    Expression<String>? building,
    Expression<String>? photo,
    Expression<DateTime>? dateCreated,
    Expression<DateTime>? dateModified,
    Expression<String>? gpsLocation,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (value != null) 'value': value,
      if (value1 != null) 'value1': value1,
      if (value2 != null) 'value2': value2,
      if (value3 != null) 'value3': value3,
      if (valueType != null) 'value_type': valueType,
      if (unit != null) 'unit': unit,
      if (notes != null) 'notes': notes,
      if (room != null) 'room': room,
      if (building != null) 'building': building,
      if (photo != null) 'photo': photo,
      if (dateCreated != null) 'date_created': dateCreated,
      if (dateModified != null) 'date_modified': dateModified,
      if (gpsLocation != null) 'gps_location': gpsLocation,
      if (tags != null) 'tags': tags,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<String>? value,
    Value<double?>? value1,
    Value<double?>? value2,
    Value<double?>? value3,
    Value<int>? valueType,
    Value<String>? unit,
    Value<String>? notes,
    Value<String>? room,
    Value<String?>? building,
    Value<String?>? photo,
    Value<DateTime>? dateCreated,
    Value<DateTime>? dateModified,
    Value<String?>? gpsLocation,
    Value<String>? tags,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      value: value ?? this.value,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
      value3: value3 ?? this.value3,
      valueType: valueType ?? this.valueType,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      room: room ?? this.room,
      building: building ?? this.building,
      photo: photo ?? this.photo,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      gpsLocation: gpsLocation ?? this.gpsLocation,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (value1.present) {
      map['value1'] = Variable<double>(value1.value);
    }
    if (value2.present) {
      map['value2'] = Variable<double>(value2.value);
    }
    if (value3.present) {
      map['value3'] = Variable<double>(value3.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<int>(valueType.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (building.present) {
      map['building'] = Variable<String>(building.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (dateModified.present) {
      map['date_modified'] = Variable<DateTime>(dateModified.value);
    }
    if (gpsLocation.present) {
      map['gps_location'] = Variable<String>(gpsLocation.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('value: $value, ')
          ..write('value1: $value1, ')
          ..write('value2: $value2, ')
          ..write('value3: $value3, ')
          ..write('valueType: $valueType, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('room: $room, ')
          ..write('building: $building, ')
          ..write('photo: $photo, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('dateModified: $dateModified, ')
          ..write('gpsLocation: $gpsLocation, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
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
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
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
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  const Category({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(id: Value(id), name: Value(name));
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
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

  Category copyWith({int? id, String? name}) =>
      Category(id: id ?? this.id, name: name ?? this.name);
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
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
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoriesCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items, categories];
}

typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String title,
      required String category,
      required String value,
      Value<double?> value1,
      Value<double?> value2,
      Value<double?> value3,
      required int valueType,
      required String unit,
      required String notes,
      required String room,
      Value<String?> building,
      Value<String?> photo,
      Value<DateTime> dateCreated,
      Value<DateTime> dateModified,
      Value<String?> gpsLocation,
      required String tags,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<String> value,
      Value<double?> value1,
      Value<double?> value2,
      Value<double?> value3,
      Value<int> valueType,
      Value<String> unit,
      Value<String> notes,
      Value<String> room,
      Value<String?> building,
      Value<String?> photo,
      Value<DateTime> dateCreated,
      Value<DateTime> dateModified,
      Value<String?> gpsLocation,
      Value<String> tags,
    });

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value1 => $composableBuilder(
    column: $table.value1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value2 => $composableBuilder(
    column: $table.value2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value3 => $composableBuilder(
    column: $table.value3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get building => $composableBuilder(
    column: $table.building,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value1 => $composableBuilder(
    column: $table.value1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value2 => $composableBuilder(
    column: $table.value2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value3 => $composableBuilder(
    column: $table.value3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get building => $composableBuilder(
    column: $table.building,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get value1 =>
      $composableBuilder(column: $table.value1, builder: (column) => column);

  GeneratedColumn<double> get value2 =>
      $composableBuilder(column: $table.value2, builder: (column) => column);

  GeneratedColumn<double> get value3 =>
      $composableBuilder(column: $table.value3, builder: (column) => column);

  GeneratedColumn<int> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

  GeneratedColumn<String> get building =>
      $composableBuilder(column: $table.building, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<DateTime> get dateCreated => $composableBuilder(
    column: $table.dateCreated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, BaseReferences<_$AppDatabase, $ItemsTable, Item>),
          Item,
          PrefetchHooks Function()
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<double?> value1 = const Value.absent(),
                Value<double?> value2 = const Value.absent(),
                Value<double?> value3 = const Value.absent(),
                Value<int> valueType = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> room = const Value.absent(),
                Value<String?> building = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<DateTime> dateCreated = const Value.absent(),
                Value<DateTime> dateModified = const Value.absent(),
                Value<String?> gpsLocation = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                title: title,
                category: category,
                value: value,
                value1: value1,
                value2: value2,
                value3: value3,
                valueType: valueType,
                unit: unit,
                notes: notes,
                room: room,
                building: building,
                photo: photo,
                dateCreated: dateCreated,
                dateModified: dateModified,
                gpsLocation: gpsLocation,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                required String value,
                Value<double?> value1 = const Value.absent(),
                Value<double?> value2 = const Value.absent(),
                Value<double?> value3 = const Value.absent(),
                required int valueType,
                required String unit,
                required String notes,
                required String room,
                Value<String?> building = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<DateTime> dateCreated = const Value.absent(),
                Value<DateTime> dateModified = const Value.absent(),
                Value<String?> gpsLocation = const Value.absent(),
                required String tags,
              }) => ItemsCompanion.insert(
                id: id,
                title: title,
                category: category,
                value: value,
                value1: value1,
                value2: value2,
                value3: value3,
                valueType: valueType,
                unit: unit,
                notes: notes,
                room: room,
                building: building,
                photo: photo,
                dateCreated: dateCreated,
                dateModified: dateModified,
                gpsLocation: gpsLocation,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, BaseReferences<_$AppDatabase, $ItemsTable, Item>),
      Item,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, required String name});
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, Value<String> name});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
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

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => CategoriesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  CategoriesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'1208ef0d4dcc44e993afd4ad86a3907c5602a73f';

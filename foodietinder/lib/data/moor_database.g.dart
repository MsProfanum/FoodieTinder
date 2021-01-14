// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Food extends DataClass implements Insertable<Food> {
  final int id;
  final String name;
  Food({@required this.id, @required this.name});
  factory Food.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Food(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  FoodsCompanion toCompanion(bool nullToAbsent) {
    return FoodsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Food.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Food(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Food copyWith({int id, String name}) => Food(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Food(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Food && other.id == this.id && other.name == this.name);
}

class FoodsCompanion extends UpdateCompanion<Food> {
  final Value<int> id;
  final Value<String> name;
  const FoodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  FoodsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<Food> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  FoodsCompanion copyWith({Value<int> id, Value<String> name}) {
    return FoodsCompanion(
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
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FoodsTable extends Foods with TableInfo<$FoodsTable, Food> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoodsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $FoodsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'foods';
  @override
  final String actualTableName = 'foods';
  @override
  VerificationContext validateIntegrity(Insertable<Food> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Food map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Food.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FoodsTable createAlias(String alias) {
    return $FoodsTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final String imagePath;
  Tag({@required this.id, @required this.name, @required this.imagePath});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  Tag copyWith({int id, String name, String imagePath}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, imagePath.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.imagePath == this.imagePath);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imagePath;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String imagePath,
  })  : name = Value(name),
        imagePath = Value(imagePath);
  static Insertable<Tag> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  TagsCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> imagePath}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
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
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 20);
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, imagePath];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class FoodEntry extends DataClass implements Insertable<FoodEntry> {
  final int foodId;
  final int tagId;
  FoodEntry({@required this.foodId, @required this.tagId});
  factory FoodEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return FoodEntry(
      foodId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}food_id']),
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<int>(foodId);
    }
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      foodId:
          foodId == null && nullToAbsent ? const Value.absent() : Value(foodId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
    );
  }

  factory FoodEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FoodEntry(
      foodId: serializer.fromJson<int>(json['foodId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'foodId': serializer.toJson<int>(foodId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  FoodEntry copyWith({int foodId, int tagId}) => FoodEntry(
        foodId: foodId ?? this.foodId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('FoodEntry(')
          ..write('foodId: $foodId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(foodId.hashCode, tagId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          other.foodId == this.foodId &&
          other.tagId == this.tagId);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntry> {
  final Value<int> foodId;
  final Value<int> tagId;
  const FoodEntriesCompanion({
    this.foodId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    @required int foodId,
    @required int tagId,
  })  : foodId = Value(foodId),
        tagId = Value(tagId);
  static Insertable<FoodEntry> custom({
    Expression<int> foodId,
    Expression<int> tagId,
  }) {
    return RawValuesInsertable({
      if (foodId != null) 'food_id': foodId,
      if (tagId != null) 'tag_id': tagId,
    });
  }

  FoodEntriesCompanion copyWith({Value<int> foodId, Value<int> tagId}) {
    return FoodEntriesCompanion(
      foodId: foodId ?? this.foodId,
      tagId: tagId ?? this.tagId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (foodId.present) {
      map['food_id'] = Variable<int>(foodId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('foodId: $foodId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }
}

class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $FoodEntriesTable(this._db, [this._alias]);
  final VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  GeneratedIntColumn _foodId;
  @override
  GeneratedIntColumn get foodId => _foodId ??= _constructFoodId();
  GeneratedIntColumn _constructFoodId() {
    return GeneratedIntColumn(
      'food_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedIntColumn _tagId;
  @override
  GeneratedIntColumn get tagId => _tagId ??= _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn(
      'tag_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [foodId, tagId];
  @override
  $FoodEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'food_entries';
  @override
  final String actualTableName = 'food_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id'], _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id'], _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FoodEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FoodEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FoodsTable _foods;
  $FoodsTable get foods => _foods ??= $FoodsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $FoodEntriesTable _foodEntries;
  $FoodEntriesTable get foodEntries => _foodEntries ??= $FoodEntriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [foods, tags, foodEntries];
}

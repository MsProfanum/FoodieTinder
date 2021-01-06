import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get tagName =>
      text().nullable().customConstraint('NULL REFERENCES tags(name)')();
}

class Tags extends Table {
  TextColumn get name => text().withLength(min: 1, max: 20)();

  @override
  Set<Column> get primaryKey => {name};
}

class FoodWithTag {
  final Food food;
  final Tag tag;

  FoodWithTag({
    @required this.food,
    @required this.tag,
  });
}

@UseMoor(tables: [Foods, Tags], daos: [FoodDao, TagDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          (FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          )),
        );

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.addColumn(foods, foods.tagName);
            await migrator.createTable(tags);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

@UseDao(tables: [Foods, Tags])
class FoodDao extends DatabaseAccessor<AppDatabase> with _$FoodDaoMixin {
  final AppDatabase db;

  FoodDao(this.db) : super(db);

  Future<List<Food>> getAllFoods() => select(foods).get();
  Stream<List<FoodWithTag>> watchAllFoods() {
    return (select(foods)
          ..orderBy(
            [
              (t) => OrderingTerm(expression: t.name),
            ],
          ))
        .join(
          [
            leftOuterJoin(tags, tags.name.equalsExp(foods.tagName)),
          ],
        )
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return FoodWithTag(
                food: row.readTable(foods),
                tag: row.readTable(tags),
              );
            },
          ).toList(),
        );
  }

  Future insertFood(Insertable<Food> food) => into(foods).insert(food);
  Future updateFood(Insertable<Food> food) => update(foods).replace(food);
  Future deleteFood(Insertable<Food> food) => delete(foods).delete(food);
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> watchTags() => select(tags).watch();
  Future insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
}

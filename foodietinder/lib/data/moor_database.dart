import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

part 'moor_database.g.dart';

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get imagePath => text()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  TextColumn get imagePath => text()();
}

@DataClassName('FoodEntry')
class FoodEntries extends Table {
  IntColumn get foodId => integer()();
  IntColumn get tagId => integer()();
}

class FoodWithTags {
  final Food food;
  final List<Tag> tags;

  FoodWithTags({
    @required this.food,
    @required this.tags,
  });
}

@UseMoor(tables: [Foods, Tags, FoodEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          (FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            logStatements: true,
          )),
        );

  @override
  int get schemaVersion => 1;

  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await prepareDb();
        },
        onUpgrade: (Migrator m, int from, int to) async {},
      );

  Future<void> writeFood(FoodWithTags entry) {
    return transaction(() async {
      final food = entry.food;

      await (delete(foodEntries)
            ..where((entry) => entry.foodId.equals(food.id)))
          .go();

      for (final tag in entry.tags) {
        await into(foodEntries)
            .insert(FoodEntry(foodId: food.id, tagId: tag.id));
      }
    });
  }

  Future<FoodWithTags> createFoodWithTags(Food food, List<Tag> tags) async {
    return FoodWithTags(food: food, tags: tags);
  }

  Stream<FoodWithTags> watchFood(int id) {
    final foodQuery = select(foods)..where((food) => food.id.equals(id));

    final contentQuery = select(foodEntries).join(
      [
        innerJoin(
          tags,
          tags.id.equalsExp(foodEntries.tagId),
        ),
      ],
    );

    final foodStream = foodQuery.watchSingle();

    final contentStream = contentQuery.watch().map((rows) {
      return rows.map((row) => row.readTable(tags)).toList();
    });

    return Rx.combineLatest2(foodStream, contentStream,
        (Food food, List<Tag> tags) {
      return FoodWithTags(food: food, tags: tags);
    });
  }

  Stream<List<FoodWithTags>> watchAllFoods() {
    final foodStream = select(foods).watch();

    return foodStream.switchMap((foods) {
      final idToFood = {for (var food in foods) food.id: food};
      final ids = idToFood.keys;

      final entryQuery = select(foodEntries).join(
        [innerJoin(tags, tags.id.equalsExp(foodEntries.tagId))],
      )..where(foodEntries.foodId.isIn(ids));

      return entryQuery.watch().map((rows) {
        final idToTags = <int, List<Tag>>{};

        for (var row in rows) {
          final tag = row.readTable(tags);
          final id = row.readTable(foodEntries).foodId;

          idToTags.putIfAbsent(id, () => []).add(tag);
        }

        return [
          for (var id in ids)
            FoodWithTags(food: idToFood[id], tags: idToTags[id] ?? [])
        ];
      });
    });
  }

  Future<void> insertTag(Tag tag) => into(tags).insert(tag);
  Future<void> insertFood(Food food) => into(foods).insert(food);

  Future<Tag> getTagByName(var name) =>
      (select(tags)..where((t) => t.name.equals(name))).getSingle();

  Future<List<Tag>> getTags(var foodTags) async {
    List<Tag> tags = [];
    for (var tag in foodTags) {
      tags.add(await getTagByName(tag));
    }

    return tags;
  }

  Future<Food> getFoodByName(var name) =>
      (select(foods)..where((t) => t.name.equals(name))).getSingle();

  Stream<List<Tag>> watchAllTags() => select(tags).watch();

  Stream<List<FoodEntry>> watchAllFoodEntries() => select(foodEntries).watch();

  Future<void> prepareDb() async {
    Map<String, dynamic> database =
        json.decode(await rootBundle.loadString('assets/database.json'));

    List<FoodWithTags> foodWithTagsList = [];

    for (var tag in database['tags']) {
      insertTag(new Tag(name: tag['name'], imagePath: tag['imagePath']));
    }

    for (var food in database['foods']) {
      insertFood(new Food(name: food['name'], imagePath: food['imagePath']));
    }

    for (var food in database['foods']) {
      FoodWithTags foodWithTags = await createFoodWithTags(
          await getFoodByName(food['name']), await getTags(food['tags']));
      foodWithTagsList.add(foodWithTags);
    }

    foodWithTagsList.forEach((element) {
      writeFood(element);
    });
  }
}

import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';

part 'moor_database.g.dart';

class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
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

  Future<Food> getFoodByName(var name) =>
      (select(foods)..where((t) => t.name.equals(name))).getSingle();

  Stream<List<Tag>> watchAllTags() => select(tags).watch();

  Stream<List<FoodEntry>> watchAllFoodEntries() => select(foodEntries).watch();

  Future<void> prepareDb() async {
    insertTag(new Tag(name: "salty"));
    insertTag(new Tag(name: "sweet"));
    insertTag(new Tag(name: "savory"));
    insertTag(new Tag(name: "cheesy"));
    insertTag(new Tag(name: "snack"));
    insertTag(new Tag(name: "spicy"));
    insertTag(new Tag(name: "fast food"));
    insertTag(new Tag(name: "vegetarian"));
    insertTag(new Tag(name: "dairy"));
    insertTag(new Tag(name: "cold"));
    insertTag(new Tag(name: "with meat"));
    insertTag(new Tag(name: "noodles"));
    insertTag(new Tag(name: "fruity"));
    insertTag(new Tag(name: "asian"));
    insertTag(new Tag(name: "european"));
    insertTag(new Tag(name: "with greens"));
    insertTag(new Tag(name: "fried"));

    insertFood(new Food(name: "Chips"));
    insertFood(new Food(name: "Chocolate Cake"));
    insertFood(new Food(name: "Ice cream"));
    insertFood(new Food(name: "Pizza"));
    insertFood(new Food(name: "Veggie burger"));
    insertFood(new Food(name: "Hot dog"));
    insertFood(new Food(name: "Hot wings"));
    insertFood(new Food(name: "Cookies"));
    insertFood(new Food(name: "Ramen"));
    insertFood(new Food(name: "Smoothie"));
    insertFood(new Food(name: "Bolognese"));
    insertFood(new Food(name: "Greek salad"));

    FoodWithTags chips =
        await createFoodWithTags(await getFoodByName("Chips"), [
      await getTagByName("salty"),
      await getTagByName("cheesy"),
      await getTagByName("snack"),
    ]);

    FoodWithTags chocolate_cake =
        await createFoodWithTags(await getFoodByName("Chocolate Cake"), [
      await getTagByName("sweet"),
    ]);

    FoodWithTags ice_cream =
        await createFoodWithTags(await getFoodByName("Ice cream"), [
      await getTagByName("sweet"),
      await getTagByName("snack"),
      await getTagByName("cold"),
      await getTagByName("dairy"),
    ]);

    FoodWithTags pizza =
        await createFoodWithTags(await getFoodByName("Pizza"), [
      await getTagByName("savory"),
      await getTagByName("cheesy"),
      await getTagByName("fast food"),
    ]);

    FoodWithTags veggie_burger =
        await createFoodWithTags(await getFoodByName("Veggie burger"), [
      await getTagByName("savory"),
      await getTagByName("cheesy"),
      await getTagByName("fast food"),
      await getTagByName("vegetarian"),
    ]);

    FoodWithTags hot_dog =
        await createFoodWithTags(await getFoodByName("Hot dog"), [
      await getTagByName("savory"),
      await getTagByName("with meat"),
      await getTagByName("fast food"),
      await getTagByName("snack"),
    ]);

    FoodWithTags hot_wings =
        await createFoodWithTags(await getFoodByName("Hot wings"), [
      await getTagByName("savory"),
      await getTagByName("fast food"),
      await getTagByName("spicy"),
      await getTagByName("with meat"),
    ]);

    FoodWithTags cookies =
        await createFoodWithTags(await getFoodByName("Cookies"), [
      await getTagByName("sweet"),
      await getTagByName("snack"),
    ]);

    FoodWithTags ramen =
        await createFoodWithTags(await getFoodByName("Ramen"), [
      await getTagByName("asian"),
      await getTagByName("noodles"),
      await getTagByName("savory"),
    ]);

    FoodWithTags smoothie =
        await createFoodWithTags(await getFoodByName("Smoothie"), [
      await getTagByName("sweet"),
      await getTagByName("snack"),
      await getTagByName("fruity"),
      await getTagByName("dairy"),
    ]);

    FoodWithTags bolognese =
        await createFoodWithTags(await getFoodByName("Bolognese"), [
      await getTagByName("savory"),
      await getTagByName("noodles"),
      await getTagByName("spicy"),
      await getTagByName("with meat"),
      await getTagByName("european")
    ]);

    FoodWithTags greek_salad =
        await createFoodWithTags(await getFoodByName("Greek salad"), [
      await getTagByName("with greens"),
      await getTagByName("savory"),
      await getTagByName("european")
    ]);

    writeFood(chips);
    writeFood(chocolate_cake);
    writeFood(ice_cream);
    writeFood(pizza);
    writeFood(veggie_burger);
    writeFood(hot_dog);
    writeFood(hot_wings);
    writeFood(cookies);
    writeFood(ramen);
    writeFood(smoothie);
    writeFood(bolognese);
    writeFood(greek_salad);
  }
}

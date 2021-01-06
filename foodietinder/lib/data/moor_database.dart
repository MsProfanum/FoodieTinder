import 'package:moor/moor.dart' as m;
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart' as mf;

part 'moor_database.g.dart';

class Foods extends mf.Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Tags extends mf.Table {
  TextColumn get name => text().withLength(min: 1, max: 20)();
  @override
  Set<m.Column> get primaryKey => {name};
}

@UseMoor(tables: [Foods])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((mf.FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Future<List<Food>> getAllFoods() => select(foods).get();
  Stream<List<Food>> watchAllFoods() => select(foods).watch();
  Future insertFood(Food food) => into(foods).insert(food);
  Future updateFood(Food food) => update(foods).replace(food);
  Future deleteFood(Food food) => delete(foods).delete(food);
}

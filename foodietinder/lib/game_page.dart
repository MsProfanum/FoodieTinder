import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodietinder/food_input.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: _buildFoodList(context),
            ),
            NewFoodInput(),
          ],
        ),
      ),
    );
  }
}

StreamBuilder<List<Food>> _buildFoodList(BuildContext context) {
  final database = Provider.of<AppDatabase>(context);

  return StreamBuilder(
    stream: database.watchAllFoods(),
    builder: (context, AsyncSnapshot<List<Food>> snapshot) {
      final foods = snapshot.data ?? List();

      return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (_, index) {
          final itemFood = foods[index];
          return _buildListItem(itemFood, database);
        },
      );
    },
  );
}

Widget _buildListItem(Food itemFood, AppDatabase database) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => database.deleteFood(itemFood),
      )
    ],
    child: ListTile(
      title: Text(itemFood.name),
    ),
  );
}

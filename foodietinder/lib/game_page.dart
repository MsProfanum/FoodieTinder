import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodietinder/food_input.dart';
import 'package:foodietinder/tag_input.dart';
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
            NewTagInput(),
          ],
        ),
      ),
    );
  }
}

StreamBuilder<List<FoodWithTag>> _buildFoodList(BuildContext context) {
  final dao = Provider.of<FoodDao>(context);

  return StreamBuilder(
    stream: dao.watchAllFoods(),
    builder: (context, AsyncSnapshot<List<FoodWithTag>> snapshot) {
      final foods = snapshot.data ?? List();

      return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (_, index) {
          final itemFood = foods[index];
          return _buildListItem(itemFood, dao);
        },
      );
    },
  );
}

Widget _buildListItem(FoodWithTag itemFood, FoodDao dao) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => dao.deleteFood(itemFood.food),
      )
    ],
    child: ListTile(
      title: Text(itemFood.food.name),
      subtitle: _buildTag(itemFood.tag),
    ),
  );
}

Text _buildTag(Tag tag) {
  return Text(
    tag.name,
    style: TextStyle(color: Colors.black.withOpacity(0.5)),
  );
}

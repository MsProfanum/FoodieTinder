import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';
import 'data/tag_card.dart';

class GamePage extends StatefulWidget {
  List<FoodWithTags> foodWithTags;
  List<Tag> tags;

  GamePage({Key key, @required this.foodWithTags, @required this.tags})
      : super(key: key);

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
              child:
                  TagCard(foodWithTags: widget.foodWithTags, tags: widget.tags),
            ),
          ],
        ),
      ),
    );
  }
}

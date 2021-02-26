import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/widgets/tag_card.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 155, 184, 36),
                Color.fromARGB(255, 98, 156, 44),
                Color.fromARGB(255, 18, 81, 30),
              ]),
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: TagCard(
                    foodWithTags: widget.foodWithTags, tags: widget.tags),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

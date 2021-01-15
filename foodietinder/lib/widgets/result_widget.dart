import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/widgets/result_icon.dart';

class ResultWidget extends StatelessWidget {
  final List<FoodWithTags> foodWithTags;
  final VoidCallback refresh;

  ResultWidget({@required this.foodWithTags, @required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ResultIcon(icon: 'assets/icons8-salt-shaker.png'),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
        ),
        Text(
          foodWithTags[0].food.name.toUpperCase(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("PLAY AGAIN",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              icon: Icon(Icons.refresh),
              iconSize: 30,
              onPressed: () => refresh(),
            )
          ],
        )
      ],
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/widgets/result_icon.dart';

class ResultWidget extends StatelessWidget {
  final List<FoodWithTags> foodWithTags;
  final VoidCallback refresh;
  Future<AudioPlayer> playLocalAsset;

  ResultWidget(
      {@required this.foodWithTags,
      @required this.refresh,
      this.playLocalAsset});

  @override
  Widget build(BuildContext context) {
    playLocalAsset;
    return Column(
      children: [
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResultIcon(icon: 'assets/${foodWithTags[0].food.imagePath}'),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            Text(
              foodWithTags[0].food.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 42, color: Colors.white, fontFamily: 'Monoton'),
            ),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PLAY AGAIN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withAlpha(150),
                )),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 30,
              onPressed: () => refresh(),
              color: Colors.white.withAlpha(200),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
        )
      ],
    );
  }
}

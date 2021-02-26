import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/widgets/result_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultWidget extends StatelessWidget {
  final List<FoodWithTags> foodWithTags;
  final VoidCallback refresh;
  var _random = new Random();
  Future<AudioPlayer> playLocalAsset;

  ResultWidget(
      {@required this.foodWithTags,
      @required this.refresh,
      this.playLocalAsset});

  @override
  Widget build(BuildContext context) {
    playLocalAsset;
    final result = foodWithTags[_random.nextInt(foodWithTags.length)];
    return Column(
      children: [
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResultIcon(icon: 'assets/${result.food.imagePath}'),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            Text(
              result.food.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 30.sp, color: Colors.white, fontFamily: 'Monoton'),
            ),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PLAY AGAIN",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withAlpha(150),
                )),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 30.sp,
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

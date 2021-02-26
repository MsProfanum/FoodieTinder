import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:foodietinder/widgets/result_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoClueResultWidget extends StatelessWidget {
  final String iconString;
  final VoidCallback refresh;
  Future<AudioPlayer> playLocalAsset;

  NoClueResultWidget(
      {@required this.iconString, @required this.refresh, this.playLocalAsset});

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
            ResultIcon(icon: iconString),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
            ),
            Text(
              "NO CLUE",
              style: TextStyle(
                  fontSize: 42.sp, color: Colors.white, fontFamily: 'Monoton'),
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
          padding: EdgeInsets.only(bottom: 50.h),
        )
      ],
    );
  }
}

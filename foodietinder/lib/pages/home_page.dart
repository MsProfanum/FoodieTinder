import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/widgets/particles.dart';
import 'package:foodietinder/widgets/start_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchAllFoods(),
      builder: (context, snap) {
        if (snap.hasData) {
          return StreamBuilder(
            stream: database.watchAllTags(),
            builder: (context, shot) {
              if (shot.hasData) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(child: Particles(30)),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                        ),
                        SizedBox(
                          child: ColorizeAnimatedTextKit(
                            text: ["FOOD MATCHER"],
                            textStyle: TextStyle(
                                fontSize: 42.sp, fontFamily: 'Monoton'),
                            textAlign: TextAlign.left,
                            colors: [
                              Color.fromARGB(255, 98, 156, 44),
                              Color.fromARGB(255, 18, 81, 30),
                              Color.fromARGB(255, 155, 184, 36),
                            ],
                            repeatForever: true,
                            speed: Duration(milliseconds: 300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 170.h),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StartButtonWidget(
                                  foods: snap.data, tags: shot.data)
                            ],
                          ),
                        ),
                        Spacer(),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                  color: Colors.black.withAlpha(150),
                                ),
                                text: "Icons provided by: "),
                            TextSpan(
                                style: TextStyle(
                                  color: Color.fromARGB(255, 98, 156, 44),
                                ),
                                text: "Icons8",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url =
                                        "https://icons8.com/icon/set/food/color";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  })
                          ]),
                        )
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60.w,
                        height: 60.h,
                      ),
                    ],
                  ),
                );
              }
            },
          );
        } else {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60.w,
              height: 60.h,
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/feedback_position_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => FeedbackPositionProvider(),
        child: Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          child: ScreenUtilInit(
            designSize: Size(411, 845),
            allowFontScaling: true,
            builder: () => MaterialApp(
              title: 'Foodie tinder',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Colors.white,
                body: HomePage(),
              ),
            ),
          ),
        ),
      );
}

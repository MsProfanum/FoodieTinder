import 'package:flutter/material.dart';
import 'package:foodietinder/data/feedback_position_provider.dart';
import 'package:foodietinder/data/moor_database.dart';
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
          child: MaterialApp(
            title: 'Foodie tinder',
            home: Scaffold(
              backgroundColor: Colors.white,
              body: HomePage(),
            ),
          ),
        ),
      );
}

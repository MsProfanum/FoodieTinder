import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();
    return MultiProvider(
      providers: [
        Provider(builder: (_) => db.foodDao),
        Provider(builder: (_) => db.tagDao),
      ],
      child: MaterialApp(
        title: 'Foodie tinder',
        home: Scaffold(
          backgroundColor: Colors.white,
          body: HomePage(),
        ),
      ),
    );
  }
}

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
    return Provider(
      builder: (_) => AppDatabase(),
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

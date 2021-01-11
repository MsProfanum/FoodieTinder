import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:provider/provider.dart';

import 'game_page.dart';

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
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.green),
                    child: Container(
                      width: 250,
                      height: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Text(
                        'START',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(_createRoute(snap.data, shot.data));
                    },
                  ),
                );
              } else {
                return SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                );
              }
            },
          );
        } else {
          return SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          );
        }
      },
    );
  }
}

Route _createRoute(List<FoodWithTags> foods, List<Tag> tags) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        GamePage(foodWithTags: foods, tags: tags),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

import 'package:flutter/material.dart';

import 'game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(), primary: Colors.green),
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Text(
            'START',
            style: TextStyle(fontSize: 40),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => GamePage(),
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

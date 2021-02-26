import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/game_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartButtonWidget extends StatefulWidget {
  final List<FoodWithTags> foods;
  final List<Tag> tags;

  StartButtonWidget({@required this.foods, @required this.tags});
  @override
  _StartButtonWidgetState createState() => _StartButtonWidgetState();
}

class _StartButtonWidgetState extends State<StartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return _animatedButton();
  }

  Widget _animatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: CircleBorder()),
      child: Container(
        width: 250.w,
        height: 250.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 155, 184, 36),
                  Color.fromARGB(255, 98, 156, 44),
                  Color.fromARGB(255, 18, 81, 30),
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ]),
        child: Text(
          'START',
          style: TextStyle(
              fontSize: 50.sp, color: Colors.white, fontFamily: 'Monoton'),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(_createRoute(widget.foods, widget.tags));
      },
    );
  }
}

Route _createRoute(List<FoodWithTags> foods, List<Tag> tags) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) =>
        GamePage(foodWithTags: foods, tags: tags),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeInBack;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

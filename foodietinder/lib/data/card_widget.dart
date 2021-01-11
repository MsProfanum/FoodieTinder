import 'package:flutter/material.dart';
import 'package:foodietinder/data/feedback_position_provider.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/data/tag_item.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  final TagItem tag;
  final bool isInFocus;
  const CardWidget({Key key, @required this.tag, @required this.isInFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.5,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/icon.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.5)],
          gradient: LinearGradient(
            colors: [Colors.black12, Colors.black87],
            begin: Alignment.center,
            stops: [0.4, 1],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                right: 10,
                left: 10,
                bottom: 10,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [buildInfo(tag: tag)],
                  ),
                )),
            if (isInFocus) buildLikeBadge(swipingDirection)
          ],
        ),
      ),
    );
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color = isSwipingRight ? Colors.green : Colors.pink;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: 20,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              isSwipingRight ? 'LIKE' : 'NOPE',
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildInfo({@required TagItem tag}) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          tag.name.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 54,
          ),
        ),
      );
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodietinder/feedback_position_provider.dart';
import 'package:foodietinder/tag_item.dart';
import 'package:foodietinder/widgets/card_icon.dart';
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
        height: size.height * 0.4,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardIcon(
                    icon: 'assets/${tag.imagePath}',
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 80),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 50),
                    child: WavyAnimatedTextKit(
                      speed: Duration(milliseconds: 170),
                      textStyle: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      text: [tag.name.toUpperCase()],
                      textAlign: TextAlign.center,
                      isRepeatingAnimation: false,
                      repeatForever: false,
                    ),
                  )
                ],
              ),
            ),
            if (isInFocus) buildLikeBadge(swipingDirection),
          ],
        ));
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color = isSwipingRight ? Colors.green : Colors.pink;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: 40,
        right: isSwipingRight ? null : 30,
        left: isSwipingRight ? 30 : null,
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
}

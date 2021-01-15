import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardIcon extends StatefulWidget {
  final String icon;

  CardIcon({@required this.icon});

  @override
  _CardIconState createState() => _CardIconState();
}

class _CardIconState extends State<CardIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Transform.scale(
        scale: 1.2,
        child: Transform.rotate(
          angle: -0.20,
          child: Image(
            image: AssetImage(widget.icon),
          ),
        ),
      ),
      builder: (context, child) => Transform.rotate(
        angle: _controller.value * 0.45,
        child: child,
      ),
    );
  }
}

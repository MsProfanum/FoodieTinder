import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResultIcon extends StatefulWidget {
  final String icon;

  ResultIcon({@required this.icon});

  @override
  _ResultIconState createState() => _ResultIconState();
}

class _ResultIconState extends State<ResultIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _controller.forward();
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
        child: Image(
          image: AssetImage(widget.icon),
        ),
      ),
      builder: (context, child) => Transform.scale(
        scale: _controller.value * 1.5,
        child: child,
      ),
    );
  }
}

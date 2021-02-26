import 'package:flutter/cupertino.dart';

class TagItem {
  final int id;
  final String name;
  final String imagePath;
  bool isLiked;
  bool isSwipedOff;

  TagItem({
    @required this.id,
    @required this.name,
    @required this.imagePath,
    this.isLiked = false,
    this.isSwipedOff = false,
  });
}

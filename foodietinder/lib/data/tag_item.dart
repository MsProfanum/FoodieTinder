import 'package:flutter/cupertino.dart';

class TagItem {
  final int id;
  final String name;
  bool isLiked;
  bool isSwipedOff;

  TagItem({
    @required this.id,
    @required this.name,
    this.isLiked = false,
    this.isSwipedOff = false,
  });
}

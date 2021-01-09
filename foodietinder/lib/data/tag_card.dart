import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';

final tagIndex = ValueNotifier<int>(0);
var random = new Random();

class TagCard extends StatefulWidget {
  List<FoodWithTags> foodWithTags;
  List<Tag> tags;

  TagCard({Key key, @required this.foodWithTags, @required this.tags})
      : super(key: key);

  @override
  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  @override
  Widget build(BuildContext context) {
    List<Tag> tags = widget.tags;
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: tagIndex,
            builder: (context, value, w) {
              return (widget.foodWithTags.length == 1 ||
                      widget.tags.length == 1)
                  ? Text(
                      widget.foodWithTags[0].food.name,
                      style: TextStyle(fontSize: 60),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tags[tagIndex.value].name,
                          style: TextStyle(fontSize: 34),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                                onPressed: () {
                                  _removeFoodWithoutTag(tags[tagIndex.value]);
                                  _updateTags(tags[tagIndex.value], tags);
                                  printFoods();

                                  tagIndex.value = random.nextInt(tags.length);
                                },
                                child: Text('Yes')),
                            FlatButton(
                                onPressed: () {
                                  _removeFoodWithTag(tags[tagIndex.value]);
                                  _updateTags(tags[tagIndex.value], tags);
                                  printFoods();

                                  tagIndex.value = random.nextInt(tags.length);
                                },
                                child: Text('No')),
                          ],
                        ),
                      ],
                    );
            }),
      ),
    );
  }

  void _removeFoodWithTag(Tag tag) {
    widget.foodWithTags.removeWhere((food) {
      return food.tags.contains(tag);
    });
  }

  void _removeFoodWithoutTag(Tag tag) {
    widget.foodWithTags.removeWhere((food) {
      return !food.tags.contains(tag);
    });
  }

  void printFoods() {
    widget.foodWithTags.forEach((element) {
      print(element.food.name);
    });

    print('Length: ${widget.foodWithTags.length}');
  }

  void _updateTags(Tag tag, List<Tag> tags) {
    List<Tag> newTagsList = [];
    widget.foodWithTags.forEach((element) {
      element.tags.forEach((t) {
        if (!newTagsList.contains(t) && tags.contains(t)) {
          newTagsList.add(t);
        }
      });
    });
    newTagsList.remove(tag);

    tags.clear();
    tags.addAll(newTagsList);
  }
}

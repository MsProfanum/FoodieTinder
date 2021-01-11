import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodietinder/data/card_widget.dart';
import 'package:foodietinder/data/feedback_position_provider.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/data/tag_item.dart';
import 'package:provider/provider.dart';

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
  List<TagItem> tagItems = [];
  Widget card;
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: tagIndex,
            builder: (context, value, w) {
              tagItems = _createTagItemList();
              card = buildCard(tagItems[random.nextInt(tagItems.length)]);
              return (widget.foodWithTags.length <= 1 ||
                      widget.tags.length <= 1)
                  ? Text(
                      widget.foodWithTags[0].food.name,
                      style: TextStyle(fontSize: 60),
                    )
                  : card;
            }),
      ),
    );
  }

  Widget buildCard(TagItem tag) {
    Tag t;
    widget.tags.forEach((element) {
      if (element.name == tag.name) {
        t = element;
      }
    });
    final isInFocus = true;

    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable<CardWidget>(
        child: CardWidget(tag: tag, isInFocus: isInFocus),
        childWhenDragging: Container(),
        feedback: Material(
            type: MaterialType.transparency,
            child: CardWidget(tag: tag, isInFocus: isInFocus)),
        onDragEnd: (details) => onDragEnd(details, tag, t),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, TagItem tagItem, Tag t) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      print("LIKE");
      tagItem.isLiked = true;
      _removeFoodWithoutTag(t);
      _updateTags(t, widget.tags);

      _updateTags(t, widget.tags);
    } else if (details.offset.dx < -minimumDrag) {
      print("NOPE");
      tagItem.isSwipedOff = true;
      _removeFoodWithTag(t);
      _updateTags(t, widget.tags);
    }
  }

  List<TagItem> _createTagItemList() {
    List<TagItem> tagList = [];
    widget.tags.forEach((tag) {
      tagList.add(new TagItem(id: tag.id, name: tag.name));
    });

    return tagList;
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

  void _updateTags(Tag tag, List<Tag> tags) {
    List<Tag> newTagsList = [];
    List<TagItem> newTagItemList = [];
    widget.foodWithTags.forEach((element) {
      element.tags.forEach((t) {
        if (!newTagsList.contains(t) && tags.contains(t)) {
          newTagsList.add(t);
          newTagItemList.add(new TagItem(id: t.id, name: t.name));
        }
      });
    });
    newTagsList.remove(tag);
    newTagItemList.removeWhere((element) => element.id == tag.id);
    tags.clear();
    tags.addAll(newTagsList);

    tagItems.clear();
    tagItems.addAll(newTagItemList);

    tagItems.forEach((element) {
      print(element.name);
    });
    setState(() {
      card = buildCard(tagItems[random.nextInt(tagItems.length)]);
    });
  }
}

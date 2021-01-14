import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodietinder/data/card_widget.dart';
import 'package:foodietinder/data/feedback_position_provider.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/data/tag_item.dart';

import 'package:provider/provider.dart';

final tagIndex = ValueNotifier<int>(0);
var random = new Random();
List<FoodWithTags> foodWithTagsCopy;
List<Tag> tagsCopy;

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

  @override
  void initState() {
    super.initState();
    foodWithTagsCopy = List.of(widget.foodWithTags);
    tagsCopy = List.of(widget.tags);
    tagItems = _createTagItemList();
    card = buildCard(
        tagItems[(tagItems.length > 1) ? random.nextInt(tagItems.length) : 0]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: tagIndex,
            builder: (context, value, w) {
              return (foodWithTagsCopy.length <= 1 || tagsCopy.length <= 1)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          foodWithTagsCopy[0].food.name,
                          style: TextStyle(fontSize: 60),
                        ),
                        IconButton(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          icon: Icon(Icons.refresh),
                          iconSize: 64,
                          onPressed: () => _refresh(),
                        )
                      ],
                    )
                  : card;
            }),
      ),
    );
  }

  void _refresh() {
    setState(() {
      foodWithTagsCopy = List.of(widget.foodWithTags);
      tagsCopy = List.of(widget.tags);
      tagItems = _createTagItemList();
      card = buildCard(tagItems[
          (tagItems.length > 1) ? random.nextInt(tagItems.length) : 0]);
    });
  }

  Widget buildCard(TagItem tag) {
    Tag t;
    tagsCopy.forEach((element) {
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
      tagItem.isLiked = true;
      _removeFoodWithoutTag(t);
      _updateTags(t, tagsCopy);

      _updateTags(t, tagsCopy);
    } else if (details.offset.dx < -minimumDrag) {
      tagItem.isSwipedOff = true;
      _removeFoodWithTag(t);
      _updateTags(t, tagsCopy);
    }
  }

  List<TagItem> _createTagItemList() {
    List<TagItem> tagList = [];
    tagsCopy.forEach((tag) {
      tagList.add(new TagItem(id: tag.id, name: tag.name));
    });

    return tagList;
  }

  void _removeFoodWithTag(Tag tag) {
    foodWithTagsCopy.removeWhere((food) {
      return food.tags.contains(tag);
    });
  }

  void _removeFoodWithoutTag(Tag tag) {
    foodWithTagsCopy.removeWhere((food) {
      return !food.tags.contains(tag);
    });
  }

  void _updateTags(Tag tag, List<Tag> tags) {
    List<Tag> newTagsList = [];
    List<TagItem> newTagItemList = [];
    foodWithTagsCopy.forEach((element) {
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

    setState(() {
      card = buildCard(tagItems[
          (tagItems.length > 1) ? random.nextInt(tagItems.length) : 0]);
    });
  }
}

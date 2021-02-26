import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodietinder/data/moor_database.dart';
import 'package:foodietinder/data/tag_item.dart';
import 'package:foodietinder/helper_classes/feedback_position_provider.dart';
import 'package:foodietinder/widgets/card_widget.dart';
import 'package:foodietinder/widgets/no_clue_widget.dart';
import 'package:foodietinder/widgets/result_widget.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

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
    card = buildCard(tagItems[random.nextInt(tagItems.length)]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: tagIndex,
            builder: (context, value, w) {
              return card;
            }),
      ),
    );
  }

  void refresh() {
    setState(() {
      foodWithTagsCopy = List.of(widget.foodWithTags);
      tagsCopy = List.of(widget.tags);
      tagItems = _createTagItemList();
      card = buildCard(tagItems[random.nextInt(tagItems.length)]);
    });
  }

  Widget buildCard(TagItem tagItem) {
    Tag tag;
    tagsCopy.forEach((element) {
      if (element.name == tagItem.name) {
        tag = element;
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
        child: CardWidget(tag: tagItem, isInFocus: isInFocus),
        childWhenDragging: Container(),
        feedback: Material(
            type: MaterialType.transparency,
            child: CardWidget(tag: tagItem, isInFocus: isInFocus)),
        onDragEnd: (details) => onDragEnd(details, tagItem, tag),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, TagItem tagItem, Tag tag) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      tagItem.isLiked = true;
      _removeFoodWithoutTag(tag);
      _updateTags(tag, tagsCopy);
    } else if (details.offset.dx < -minimumDrag) {
      tagItem.isSwipedOff = true;
      _removeFoodWithTag(tag);
      _updateTags(tag, tagsCopy);
    }
    if (foodWithTagsCopy.length > 1 && tagsCopy.length > 1) {
      playLocalAsset('card-swipe-sound.mp3');
    }
  }

  List<TagItem> _createTagItemList() {
    List<TagItem> tagList = [];
    tagsCopy.forEach((tag) {
      tagList.add(
          new TagItem(id: tag.id, name: tag.name, imagePath: tag.imagePath));
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

  Future<AudioPlayer> playLocalAsset(String sound) async {
    AudioCache cache = new AudioCache();
    return await cache.play(sound);
  }

  void _updateTags(Tag tag, List<Tag> tags) {
    List<Tag> newTagsList = [];
    List<TagItem> newTagItemList = [];
    foodWithTagsCopy.forEach((element) {
      element.tags.forEach((t) {
        if (!newTagsList.contains(t) && tags.contains(t)) {
          newTagsList.add(t);
          newTagItemList
              .add(new TagItem(id: t.id, name: t.name, imagePath: t.imagePath));
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
      card = (foodWithTagsCopy.length == 0 || tagsCopy.length == 0)
          ? NoClueResultWidget(
              iconString: 'assets/icons8-question-mark.png',
              refresh: refresh,
              playLocalAsset: playLocalAsset('result-sound.mp3'))
          : (foodWithTagsCopy.length == 1 || tagsCopy.length == 1)
              ? ResultWidget(
                  foodWithTags: foodWithTagsCopy,
                  refresh: refresh,
                  playLocalAsset: playLocalAsset('result-sound.mp3'),
                )
              : buildCard(tagItems[random.nextInt(tagItems.length)]);
    });
  }
}

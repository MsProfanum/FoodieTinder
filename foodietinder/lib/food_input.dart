import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';

class NewFoodInput extends StatefulWidget {
  const NewFoodInput({
    Key key,
  }) : super(key: key);

  @override
  _NewFoodInputState createState() => _NewFoodInputState();
}

class _NewFoodInputState extends State<NewFoodInput> {
  Tag selectedTag;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTextField(context),
          _buildTagSelector(context),
        ],
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Food Name'),
        onSubmitted: (inputName) {
          final dao = Provider.of<FoodDao>(context);
          final food = FoodsCompanion(
            name: Value(inputName),
            tagName: Value(selectedTag?.name),
          );
          dao.insertFood(food);
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  StreamBuilder<List<Tag>> _buildTagSelector(BuildContext context) {
    return StreamBuilder<List<Tag>>(
      stream: Provider.of<TagDao>(context).watchTags(),
      builder: (context, snapshot) {
        final tags = snapshot.data ?? List();

        DropdownMenuItem<Tag> dropdownFromTag(Tag tag) {
          return DropdownMenuItem(
            value: tag,
            child: Row(
              children: <Widget>[Text(tag.name)],
            ),
          );
        }

        final dropdownMenuItems =
            tags.map((tag) => dropdownFromTag(tag)).toList()
              ..insert(
                0,
                DropdownMenuItem(
                  value: null,
                  child: Text('No Tag'),
                ),
              );

        return Expanded(
          child: DropdownButton(
            onChanged: (Tag tag) {
              setState(() {
                selectedTag = tag;
              });
            },
            isExpanded: true,
            value: selectedTag,
            items: dropdownMenuItems,
          ),
        );
      },
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      selectedTag = null;
      controller.clear();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';

class NewTagInput extends StatefulWidget {
  const NewTagInput({
    Key key,
  }) : super(key: key);

  @override
  _NewTagInputState createState() => _NewTagInputState();
}

class _NewTagInputState extends State<NewTagInput> {
  static const Color DEFAULT_COLOR = Colors.red;

  Color pickedTagColor = DEFAULT_COLOR;
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
        children: <Widget>[
          _buildTextField(context),
        ],
      ),
    );
  }

  Flexible _buildTextField(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Tag Name'),
        onSubmitted: (inputName) {
          final dao = Provider.of<TagDao>(context);
          final task = TagsCompanion(
            name: Value(inputName),
          );
          dao.insertTag(task);
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      pickedTagColor = DEFAULT_COLOR;
      controller.clear();
    });
  }
}

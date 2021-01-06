import 'package:flutter/material.dart';
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
  DateTime newTaskDate;
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
        children: <Widget>[_buildTextField(context)],
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Food Name'),
        onSubmitted: (inputName) {
          final database = Provider.of<AppDatabase>(context);
          final food = Food(name: inputName);
          database.insertFood(food);
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      newTaskDate = null;
      controller.clear();
    });
  }
}

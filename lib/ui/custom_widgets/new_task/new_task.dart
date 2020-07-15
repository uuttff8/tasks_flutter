import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasks_flutter/model/task.dart';
import 'package:tasks_flutter/strings.dart' as str;
import 'package:tasks_flutter/ui/core_ui/exts.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'tools/camera_tool.dart';
import 'tools/date_picker_tool.dart';

class NewTask extends StatelessWidget {
  NewTask({Key key}) : super(key: key);

  final smallTextController = TextEditingController();
  final bigTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double firstTextHeight = 66.0;
    final double secondTextHeight = 120.0;
    final double toolbarHeight = 40.0;
    final double finalHeight =
        keyboardHeight + firstTextHeight + secondTextHeight + toolbarHeight;

    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: Duration(
        milliseconds: 160,
      ),
      width: double.infinity,
      height: finalHeight,
      color: TasksColors.newTask,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TasksTextTextFieldSmall(controller: smallTextController),
          TasksTextTextFieldBig(controller: bigTextController),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  DatePickerTool(),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    color: TasksColors.description_text,
                    onPressed: () {},
                  ),
                  CameraTool(),
                  Spacer(),
                  ValueListenableBuilder(
                    valueListenable:
                        Hive.box<TaskHive>(str.hiveTasks).listenable(),
                    builder: (context, Box<TaskHive> box, widget) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: CupertinoButton(
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.yellow),
                          ),
                          onPressed: () {
                            box.add(
                              TaskHive(
                                name: smallTextController.text,
                                description: bigTextController.text,
                              ),
                            );
                            Navigator.pop(context);
                            BotToast.showText(
                              text: "Task added",
                              contentColor: TasksColors.toast_color,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TasksTextTextFieldSmall extends StatelessWidget {
  const TasksTextTextFieldSmall({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: TextField(
              controller: controller,
              autofocus: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Task Name",
                hintStyle: TextStyle(color: Colors.white),
                focusColor: Colors.black45,
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupThreeDotsButton(),
          )
        ],
      ),
    );
  }
}

class PopupThreeDotsButton extends StatefulWidget {
  const PopupThreeDotsButton({
    Key key,
  }) : super(key: key);

  @override
  _PopupThreeDotsButtonState createState() => _PopupThreeDotsButtonState();
}

class _PopupThreeDotsButtonState extends State<PopupThreeDotsButton> {
  String _selection;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          _selection = value;
        });
      },
      child: FaIcon(
        FontAwesomeIcons.ellipsisH,
        size: 24,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Value1',
            child: Text('Choose value 1'),
          ),
          const PopupMenuItem<String>(
            value: 'Value2',
            child: Text('Choose value 2'),
          ),
          const PopupMenuItem<String>(
            value: 'Value3',
            child: Text('Choose value 3'),
          ),
        ];
      },
    );
  }
}

class TasksTextTextFieldBig extends StatelessWidget {
  const TasksTextTextFieldBig({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 5 * 24.0, // 120
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLength: null,
          maxLines: null,
          autofocus: true,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: "Task Description",
            hintStyle: TextStyle(color: TasksColors.description_text),
            focusColor: Colors.black45,
            border: InputBorder.none,
          ),
          style: TextStyle(color: TasksColors.description_text),
        ),
      ),
    );
  }
}

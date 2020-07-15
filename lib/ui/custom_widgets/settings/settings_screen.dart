import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_flutter/ui/custom_widgets/tasks_pages/tasks_pages.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TasksPageWithBackButton(
        text: "Settings",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.palette,
                  color: TasksColors.textColor,
                ),
                SizedBox(width: 8),
                Text(
                  "Appearance",
                  style: TextStyle(
                    color: TasksColors.textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 64.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _DescriptionText("Black Theme"),
                  SizedBox(height: 4),
                  _DescriptionText("White Theme"),
                  SizedBox(height: 4),
                  _DescriptionText("System"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText(
    this.str, {
    Key key,
  }) : super(key: key);

  final String str;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.str,
      style: TextStyle(
        fontSize: 16,
        color: TasksColors.textColor,
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        child: Container(
          height: 2.0,
          width: 100,
          color: Colors.yellow,
        ),
      ),
    );
  }
}

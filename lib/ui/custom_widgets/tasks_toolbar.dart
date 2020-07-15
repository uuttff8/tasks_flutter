import 'package:flutter/material.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';
import 'package:tasks_flutter/ui/custom_widgets/tasks_pages/tasks_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasks_flutter/ui/core_ui/tasks_text_modal_bottom_sheet.dart';

import 'package:tasks_flutter/ui/custom_widgets/new_task/new_task.dart';
import 'package:tasks_flutter/ui/custom_widgets/settings/settings_screen.dart';
import 'package:tasks_flutter/ui/custom_widgets/task_sorting.dart';

class TabbedWidgets extends StatelessWidget {
  const TabbedWidgets({Key key}) : super(key: key);
  final double bottomBarHeight = kToolbarHeight + 26;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height - bottomBarHeight,
            color: TasksColors.mainBlack,
            child: TasksPageWidgets(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TasksBottomBar(bottomBarHeight: bottomBarHeight),
        ),
      ],
    );
  }
}

class TasksBottomBar extends StatelessWidget {
  const TasksBottomBar({
    Key key,
    @required this.bottomBarHeight,
  }) : super(key: key);

  final double bottomBarHeight;

  @override
  Widget build(BuildContext context) {
    void _tapPlusButton() async {
      showTasksTextModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return _ContainerClipper(
            child: NewTask(),
          );
        },
      );
    }

    void _tapSortingButton() async {
      showTasksTextModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return _ContainerClipper(
            child: TasksSettings(),
          );
        },
      );
    }

    void _tapSettingsButton() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SettingsScreen(),
        ),
      );
    }

    return Container(
      height: bottomBarHeight,
      color: TasksColors.mainBlack,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: _tapSortingButton,
              child: FaIcon(
                FontAwesomeIcons.bars,
                color: TasksColors.iconWhite,
                size: 30,
              ),
            ),
            _PlusShader(
              child: InkWell(
                onTap: _tapPlusButton,
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: TasksColors.iconWhite,
                  size: 30,
                ),
              ),
            ),
            InkWell(
              onTap: _tapSettingsButton,
              child: FaIcon(
                FontAwesomeIcons.cog,
                color: TasksColors.iconWhite,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContainerClipper extends StatelessWidget {
  const _ContainerClipper({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: this.child,
    );
  }
}

class _PlusShader extends StatelessWidget {
  const _PlusShader({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xFFDB1639), Color(0xFFF4990D)],
      ).createShader(bounds),
      child: this.child,
    );
  }
}

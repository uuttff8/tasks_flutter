import 'package:flutter/material.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

class DatePickerTool extends StatelessWidget {
  const DatePickerTool({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.today,
        size: 26,
      ),
      color: TasksColors.description_text,
      onPressed: () async {
        DateTime date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 2000)),
        );

        if (date != null) {
          print(date);
        }
      },
    );
  }
}

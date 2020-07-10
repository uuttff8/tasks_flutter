import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';
import 'package:tasks_flutter/ui/core_ui/tasks_text_modal_bottom_sheet.dart';
import 'package:camera/camera.dart';
import '../take_picture.dart';

class CameraTool extends StatelessWidget {
  const CameraTool({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: IconButton(
        icon: Icon(
          OMIcons.cameraAlt,
          size: 26,
        ),
        color: TasksColors.description_text,
        onPressed: () async {
          final cameras = await availableCameras();
          print(cameras);
          final firstCamera = cameras.first;

          showTasksTextModalBottomSheet<void>(
            context: context,
            builder: (context) {
              return TakePictureScreen(
                camera: firstCamera,
              );
            },
          );
        },
      ),
    );
  }
}

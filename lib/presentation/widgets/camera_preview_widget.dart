import 'package:camera/camera.dart';
import 'package:capture_photo_test_app/app/camera_init.dart';
import 'package:capture_photo_test_app/app/consts/strings.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  const CameraPreviewWidget({super.key});

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  @override
  void initState() {
    super.initState();
    () async {
      final result = await CameraInit.instance.start();
      if (result.$2 is Exception) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(StringsData.cameraPermission)));
        }
      } else {
        setState(() {});
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CameraPreview(CameraInit.instance.cameraController),
        ),
      ],
    );
  }
}

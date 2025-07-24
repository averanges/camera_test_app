import 'package:capture_photo_test_app/presentation/widgets/bottom_buttons_bar.dart';
import 'package:capture_photo_test_app/presentation/widgets/camera_preview_widget.dart';
import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoUploadController>();
    final isGalleryOpen = controller.state.value.isGalleryOpen;
    return Scaffold(
      body: PopScope(
        canPop: !isGalleryOpen,
        onPopInvokedWithResult: (didPop, result) {
          if (isGalleryOpen) {
            controller.state.value = controller.state.value.copyWith(
              isGalleryOpen: false,
            );
            return;
          }
          if (didPop) {
            setState(() {});
          }
        },
        child: Stack(children: [CameraPreviewWidget(), BottomButtonsBar()]),
      ),
    );
  }
}

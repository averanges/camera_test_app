import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefreshRequestBtn extends StatelessWidget {
  const RefreshRequestBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoUploadController>();
    return InkWell(
      onTap: () async {
        if (controller.state.value.isLastPhotoUploaded) {
          return;
        }
        await controller.shotPhoto(context);
      },
      child: Obx(() {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border(top: BorderSide(color: Colors.white)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  (controller.state.value.photo == null ||
                          controller.state.value.photo!.path.isEmpty) ||
                      controller.state.value.isLastPhotoUploaded
                  ? [Colors.grey[700]!, Colors.grey[300]!]
                  : [Colors.green[700]!, Colors.green[300]!],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(Icons.refresh, color: Colors.white, size: 30),
        );
      }),
    );
  }
}

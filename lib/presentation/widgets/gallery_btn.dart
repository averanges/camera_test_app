import 'dart:io';

import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryBtn extends StatelessWidget {
  const GalleryBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoUploadController>();
    return InkWell(
      onTap: () {
        if (controller.state.value.photo == null ||
            controller.state.value.photo!.path.isEmpty) {
          return;
        }
        controller.toggleGallery(true);
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border(top: BorderSide(color: Colors.white)),
          color: Colors.grey[400],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Obx(() {
          return controller.state.value.photo != null &&
                  controller.state.value.photo!.path.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: FileImage(
                            File(controller.state.value.photo!.path),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.state.value.isLastPhotoUploaded
                              ? Colors.green
                              : Colors.red,
                        ),
                        width: 20,
                        height: 20,
                        child: Icon(
                          controller.state.value.isLastPhotoUploaded
                              ? Icons.check
                              : Icons.error,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                )
              : const Icon(Icons.image, color: Colors.white, size: 30);
        }),
      ),
    );
  }
}

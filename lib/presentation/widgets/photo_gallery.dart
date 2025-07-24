import 'dart:io';

import 'package:capture_photo_test_app/app/consts/strings.dart';
import 'package:capture_photo_test_app/app/shared_preferences.dart';
import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:capture_photo_test_app/presentation/single_photo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoUploadController>();
    return Obx(() {
      final isGalleryOpen = controller.state.value.isGalleryOpen;
      return Column(
        children: [
          AnimatedSlide(
            offset: isGalleryOpen ? const Offset(0, 0) : const Offset(1, 0),
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                InkWell(
                  onTap: controller.clearGallery,
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      border: Border(bottom: BorderSide(color: Colors.white)),
                    ),
                    child: Center(
                      child: Text(
                        StringsData.clear,
                        style: TextStyle(letterSpacing: 5),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    border: Border(bottom: BorderSide(color: Colors.white)),
                  ),
                  child: FutureBuilder(
                    future: SharedPreferencesConfig.instance.loadList(),
                    builder: (context, snapshot) {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    seconds: 1,
                                  ),
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => SinglePhotoPage(
                                        path: snapshot.data?[index].path ?? '',
                                        comment:
                                            snapshot.data?[index].comment ?? '',
                                        latitude:
                                            snapshot.data?[index].latitude ??
                                            '',
                                        longitude:
                                            snapshot.data?[index].longitude ??
                                            '',
                                      ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'photo_${snapshot.data?[index].path}',
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(snapshot.data?[index].path ?? ''),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

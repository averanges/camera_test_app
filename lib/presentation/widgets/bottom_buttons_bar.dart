import 'package:capture_photo_test_app/presentation/widgets/circled_shot_btn.dart';
import 'package:capture_photo_test_app/presentation/widgets/gallery_btn.dart';
import 'package:capture_photo_test_app/presentation/widgets/photo_gallery.dart';
import 'package:capture_photo_test_app/presentation/widgets/refresh_request_btn.dart';
import 'package:flutter/material.dart';

class BottomButtonsBar extends StatelessWidget {
  const BottomButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Column(
        children: [
          PhotoGallery(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GalleryBtn(),
              SizedBox(width: 30),
              CircledShotBtn(),
              SizedBox(width: 30),
              RefreshRequestBtn(),
            ],
          ),
        ],
      ),
    );
  }
}

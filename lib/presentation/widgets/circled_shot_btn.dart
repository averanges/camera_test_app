import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:capture_photo_test_app/presentation/widgets/arrows_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircledShotBtn extends StatelessWidget {
  const CircledShotBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhotoUploadController>();
    return GestureDetector(
      onTap: () async {
        await controller.shotPhoto();
      },
      onVerticalDragStart: (details) {
        controller.toggleDrag(true);
      },
      onVerticalDragEnd: (details) async {
        final v = details.velocity.pixelsPerSecond.dy;
        if (v < -100) {
          if (controller.state.value.isGalleryOpen) {
            controller.toggleGallery(false);
          }
          showBottomSheet(
            context: context,
            builder: (context) {
              return _buildBottomCommentSheet(controller.commentController);
            },
          );
        }
        await Future.delayed(const Duration(milliseconds: 300));
        controller.toggleDrag(false);
      },
      child: Obx(() {
        final isDraged = controller.state.value.isDraged;
        return Column(
          children: [
            Visibility(
              visible: !isDraged,
              maintainAnimation: true,
              maintainInteractivity: false,
              maintainSemantics: false,
              maintainSize: true,
              maintainState: true,
              child: ArrowsAnimatedWidget(),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 100),
              scale: isDraged ? 1.05 : 1,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Column _buildBottomCommentSheet(TextEditingController commentController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Leave Comment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  letterSpacing: 3,
                ),
              ),
              Text(
                'You can add comment before taking photo',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.5),
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.55),
                ),
                child: TextField(
                  controller: commentController,
                  minLines: 3,
                  maxLines: 3,
                  scrollController: ScrollController(),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Enter comment',
                  ),
                ),
              ),
              SizedBox(height: 10),
              ArrowsAnimatedWidget(isDown: true, size: 30),
            ],
          ),
        ),
      ],
    );
  }
}

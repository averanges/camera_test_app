import 'dart:io';

import 'package:capture_photo_test_app/app/consts/strings.dart';
import 'package:flutter/material.dart';

class SinglePhotoPage extends StatefulWidget {
  const SinglePhotoPage({
    super.key,
    required this.path,
    required this.comment,
    required this.latitude,
    required this.longitude,
  });
  final String path;
  final String comment;
  final String latitude;
  final String longitude;

  @override
  State<SinglePhotoPage> createState() => _SinglePhotoPageState();
}

class _SinglePhotoPageState extends State<SinglePhotoPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        body: Hero(
          tag: 'photo_${widget.path}',
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: FileImage(File(widget.path)),
                fit: BoxFit.cover,
              ),
            ),
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: animationController.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(StringsData.commentCategory),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.comment,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(StringsData.latitudeCategory),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.latitude,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(StringsData.longitudeCategory),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.longitude,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

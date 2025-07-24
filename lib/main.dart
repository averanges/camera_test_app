import 'package:capture_photo_test_app/presentation/camera_page.dart';
import 'package:capture_photo_test_app/presentation/controller/photo_upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:capture_photo_test_app/app/camera_init.dart';
import 'package:capture_photo_test_app/app/geolocator.dart';
import 'package:capture_photo_test_app/app/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesConfig.instance.init();
  await CameraInit.instance.init();
  await GeolocatorConfig.instance.askPermission();
  Get.put(PhotoUploadController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraPage(),
    );
  }
}

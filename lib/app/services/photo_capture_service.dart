import 'package:capture_photo_test_app/app/camera_init.dart';
import 'package:capture_photo_test_app/app/logger_config.dart';

class PhotoCaptureService {
  Future<String?> takePhoto() async {
    try {
      final file = await CameraInit.instance.cameraController.takePicture();
      return file.path;
    } catch (e) {
      LoggerConfig.instance.logger.e("Camera error: $e");
      return null;
    }
  }
}

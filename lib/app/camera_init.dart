import 'package:camera/camera.dart';
import 'package:capture_photo_test_app/app/logger_config.dart';
import 'package:permission_handler/permission_handler.dart';

typedef CameraInitial = Future<(void, Exception?)>;

class CameraInit {
  CameraInit._();

  static final _instance = CameraInit._();

  static CameraInit get instance => _instance;

  late List<CameraDescription> _cameraList;
  late CameraController _cameraController;

  CameraController get cameraController => _cameraController;

  Future<void> init() async {
    try {
      _cameraList = await availableCameras();
      _cameraController = CameraController(
        _cameraList.first,
        ResolutionPreset.high,
      );
    } catch (e) {
      LoggerConfig.instance.logger.e(e);
    }
  }

  CameraInitial start() async {
    try {
      final status = await Permission.camera.request();
      if (status.isGranted) {
        await _cameraController.initialize();
      } else {
        throw Exception('Camera permission is not granted');
      }
    } catch (e) {
      LoggerConfig.instance.logger.e(e);
      return (null, e as Exception);
    }
    return (null, null);
  }

  Future<void> dispose() async {
    await _cameraController.dispose();
  }
}

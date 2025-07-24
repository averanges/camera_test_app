import 'package:capture_photo_test_app/app/logger_config.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorConfig {
  GeolocatorConfig._();

  static final GeolocatorConfig _instance = GeolocatorConfig._();

  static GeolocatorConfig get instance => _instance;

  Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      LoggerConfig.instance.logger.e(e);
      return null;
    }
  }
}

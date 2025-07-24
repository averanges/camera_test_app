import 'package:capture_photo_test_app/app/geolocator.dart';
import 'package:capture_photo_test_app/app/logger_config.dart';

class LocationService {
  Future<(String, String)?> getCurrentPosition() async {
    try {
      final position = await GeolocatorConfig.instance.determinePosition();
      if (position == null) {
        return null;
      }
      return (position.latitude.toString(), position.longitude.toString());
    } catch (e) {
      LoggerConfig.instance.logger.e("Location error: $e");
      return null;
    }
  }
}

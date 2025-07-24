import 'package:capture_photo_test_app/data/network/dio_base.dart';
import 'package:capture_photo_test_app/domain/api/photo_upload.dart';
import 'package:capture_photo_test_app/domain/models/photo.dart';
import 'package:capture_photo_test_app/app/logger_config.dart';

class PhotoUploadImpl implements PhotoUpload {
  final DioBase dio;

  PhotoUploadImpl(this.dio);

  @override
  Future<bool> uploadPhoto(Photo photo) async {
    try {
      final response = await DioBase.instance.post(photo);
      LoggerConfig.instance.logger.i("Upload response: $response");
      return response.statusCode == 200;
    } catch (e) {
      LoggerConfig.instance.logger.e("Upload error: $e");
      return false;
    }
  }
}

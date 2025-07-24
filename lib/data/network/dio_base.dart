import 'package:capture_photo_test_app/domain/models/photo.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class DioBase {
  late final Dio _dio;

  DioBase._()
    : _dio = Dio(
        BaseOptions(baseUrl: 'https://flutter-sandbox.free.beeceptor.com/'),
      );

  static final DioBase _instance = DioBase._();

  static DioBase get instance => _instance;

  FormData _getFormData(Photo photo) {
    return FormData.fromMap({
      'comment': photo.comment,
      'latitude': photo.latitude,
      'longitude': photo.longitude,
      'photo': MultipartFile.fromFile(
        photo.path,
        filename: basename(photo.path),
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });
  }

  Future<Response> post(Photo photo) async {
    try {
      final response = await _dio.post(
        'upload_photo/',
        data: _getFormData(photo),
        options: Options(contentType: 'multipart/form-data'),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

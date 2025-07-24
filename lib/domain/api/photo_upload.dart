import 'package:capture_photo_test_app/domain/models/photo.dart';

abstract class PhotoUpload {
  Future<bool> uploadPhoto(Photo photo);
}

import 'dart:io';

import 'package:capture_photo_test_app/app/shared_preferences.dart';
import 'package:capture_photo_test_app/domain/models/photo.dart';

class PhotoStorageService {
  Future<void> save(Photo photo) =>
      SharedPreferencesConfig.instance.addToList(photo);

  Future<List<Photo>?> load() => SharedPreferencesConfig.instance.loadList();

  Future<void> clear() => SharedPreferencesConfig.instance.clear();

  Future<void> deleteAll(List<Photo> photos) async {
    for (final p in photos) {
      final file = File(p.path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capture_photo_test_app/domain/models/photo.dart';

class SharedPreferencesConfig {
  SharedPreferencesConfig._();
  static final SharedPreferencesConfig _instance = SharedPreferencesConfig._();

  static SharedPreferencesConfig get instance => _instance;

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> addToList(Photo value) async {
    final stringifiedValue = jsonEncode(value.toJson());
    final list = await loadList();
    if (list == null) {
      await _preferences.setStringList('photos', [stringifiedValue]);
    } else {
      final stringifiedList = list.map((e) => jsonEncode(e.toJson())).toList();
      await _preferences.setStringList('photos', [
        ...stringifiedList,
        stringifiedValue,
      ]);
    }
  }

  Future<List<Photo>?> loadList() async {
    return _preferences
        .getStringList('photos')
        ?.map((e) => Photo.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> clear() async {
    await _preferences.remove('photos');
  }
}

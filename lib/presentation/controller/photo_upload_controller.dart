import 'package:capture_photo_test_app/app/services/features.dart';
import 'package:capture_photo_test_app/app/services/photo_capture_service.dart';
import 'package:capture_photo_test_app/app/services/location_service.dart';
import 'package:capture_photo_test_app/app/services/photo_storage_service.dart';
import 'package:capture_photo_test_app/app/shared_preferences.dart';
import 'package:capture_photo_test_app/data/api/photo_upload_impl.dart';
import 'package:capture_photo_test_app/data/network/dio_base.dart';
import 'package:capture_photo_test_app/domain/models/internal_state.dart';
import 'package:capture_photo_test_app/domain/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoUploadController extends GetxController {
  final _photoCapture = PhotoCaptureService();
  final _location = LocationService();
  final _storage = PhotoStorageService();
  final _uploader = PhotoUploadImpl(DioBase.instance);

  final commentController = TextEditingController();
  final Rx<InternalState> state = Rx(
    InternalState(
      isDraged: false,
      isGalleryOpen: false,
      isLastPhotoUploaded: false,
      currentComment: null,
      photo: null,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    _restoreLastSession();
  }

  Future<void> resendPhoto() async {
    final photo = state.value.photo!;
    final uploaded = await _uploader.uploadPhoto(photo);
    if (uploaded) {
      await _storage.save(photo);
    }
    state.value = state.value.copyWith(
      isLastPhotoUploaded: uploaded,
      photo: photo.copyWith(isUploaded: uploaded),
    );
  }

  Future<void> shotPhoto(BuildContext context) async {
    final path = await _photoCapture.takePhoto();
    final position = await _location.getCurrentPosition();

    if (path == null || position == null) return;

    final (lat, lng) = position;

    if (state.value.photo == null) {
      state.value = state.value.copyWith(
        photo: Photo(
          path: path,
          comment: commentController.text,
          latitude: lat,
          longitude: lng,
          isUploaded: false,
        ),
      );
      return;
    }

    final photo = state.value.photo!.copyWith(
      path: path,
      comment: commentController.text,
      latitude: lat,
      longitude: lng,
    );

    final uploaded = await _uploader.uploadPhoto(photo);

    if (uploaded) {
      await _storage.save(photo);
    }

    state.value = state.value.copyWith(
      isLastPhotoUploaded: uploaded,
      currentComment: null,
      photo: photo.copyWith(isUploaded: uploaded),
    );
    if (context.mounted) {
      Features().showUploadToast(context, success: uploaded);
    }
    commentController.clear();
    state.refresh();
  }

  void toggleGallery(bool value) {
    state.value = state.value.copyWith(isGalleryOpen: value);
  }

  void toggleDrag(bool value) {
    state.value = state.value.copyWith(isDraged: value);
  }

  void clearGallery() {
    state.value = state.value.copyWith(
      isGalleryOpen: false,
      photo: Photo.empty(),
    );
    _storage.clear();
    state.refresh();
  }

  Future<void> _restoreLastSession() async {
    final list = await SharedPreferencesConfig.instance.loadList();
    if (list != null && list.isNotEmpty) {
      final last = list.last;
      state.value = state.value.copyWith(
        photo: state.value.photo?.copyWith(
          path: last.path,
          comment: last.comment,
          latitude: last.latitude,
          longitude: last.longitude,
        ),
      );
      state.value = state.value.copyWith(
        isLastPhotoUploaded: last.isUploaded,
        currentComment: null,
      );
    }
  }
}

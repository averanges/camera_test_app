import 'package:capture_photo_test_app/domain/models/photo.dart';

class InternalState {
  final bool isDraged;
  final bool isGalleryOpen;
  final bool isLastPhotoUploaded;
  final String? currentComment;
  final Photo? photo;

  InternalState({
    required this.isDraged,
    required this.isGalleryOpen,
    required this.isLastPhotoUploaded,
    this.currentComment,
    this.photo,
  });

  InternalState copyWith({
    bool? isDraged,
    bool? isGalleryOpen,
    bool? isLastPhotoUploaded,
    String? currentComment,
    Photo? photo,
  }) {
    return InternalState(
      isDraged: isDraged ?? this.isDraged,
      isGalleryOpen: isGalleryOpen ?? this.isGalleryOpen,
      isLastPhotoUploaded: isLastPhotoUploaded ?? this.isLastPhotoUploaded,
      currentComment: currentComment ?? this.currentComment,
      photo: photo ?? this.photo,
    );
  }
}

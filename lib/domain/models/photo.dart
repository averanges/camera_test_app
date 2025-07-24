import 'dart:io';

class Photo {
  final String path;
  final String comment;
  final String latitude;
  final String longitude;
  final bool isUploaded;

  Photo({
    required this.path,
    required this.comment,
    required this.latitude,
    required this.longitude,
    this.isUploaded = false,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      path: json['path'] ?? '',
      comment: json['comment'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isUploaded: json['isUploaded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'comment': comment,
      'latitude': latitude,
      'longitude': longitude,
      'isUploaded': isUploaded,
    };
  }

  copyWith({
    String? path,
    String? comment,
    String? latitude,
    String? longitude,
    bool? isUploaded,
  }) {
    return Photo(
      path: path ?? this.path,
      comment: comment ?? this.comment,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  File toFile() {
    return File(path);
  }

  static Photo empty() {
    return Photo(
      path: '',
      comment: '',
      latitude: '',
      longitude: '',
      isUploaded: false,
    );
  }
}

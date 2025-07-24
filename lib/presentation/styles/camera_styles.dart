import 'package:flutter/material.dart';

class CameraStyles {
  static const double captureButtonSize = 70.0;
  static const double captureButtonBorderWidth = 3.0;
  static const double captureButtonIconSize = 32.0;
  static const double galleryHeight = 120.0;
  static const double galleryItemSize = 100.0;
  static const double galleryItemBorderRadius = 8.0;
  static const Duration gallerySlideDuration = Duration(milliseconds: 300);

  static Gradient cameraControlsGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.black.withValues(alpha: 0.1),
      Colors.black.withValues(alpha: 0.5),
    ],
  );
  static BoxDecoration captureButtonDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white, width: captureButtonBorderWidth),
  );

  static const TextStyle toastTextStyle = TextStyle(color: Colors.white);
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );
  static const double defaultBorderRadius = 25.0;
  static const double smallBorderRadius = 8.0;
}

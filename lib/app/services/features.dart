import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Features {
  void showUploadToast(BuildContext context, {required bool success}) {
    showToast(
      success
          ? 'Successfully sent photo to server!'
          : 'Failed to send photo to server!',
      context: context,
      position: StyledToastPosition.top,
      backgroundColor: success ? Colors.green : Colors.red,
      textStyle: const TextStyle(color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }
}

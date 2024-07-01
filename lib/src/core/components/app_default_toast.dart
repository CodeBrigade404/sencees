import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppDefaultToast {
  static void show({
    required BuildContext context,
    required String title,
    String? error,
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    Duration autoCloseDuration = const Duration(seconds: 5),
    BorderSide borderSide =
        const BorderSide(color: Color(0x589E9E9E), width: 2.0),
  }) {
    toastification.show(
      type: type,
      style: style,
      title: Text(title),
      description: Text(error ?? ""),
      autoCloseDuration: autoCloseDuration,
      borderSide: borderSide,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).dialogBackgroundColor,
        ),
      ],
    );
  }
}

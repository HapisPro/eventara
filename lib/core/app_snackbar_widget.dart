import 'package:eventara/core/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AppSnackBarWidget {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType type,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
        color: backgroundColor ?? _getColorByType(type),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccess(BuildContext context, String message) {
    show(
      context: context,
      title: 'Berhasil!',
      message: message,
      type: ContentType.success,
      backgroundColor: AppColor.success.color,
    );
  }

  static void showError(BuildContext context, String message) {
    show(
      context: context,
      title: 'Gagal!',
      message: message,
      type: ContentType.failure,
      backgroundColor: AppColor.error.color,
    );
  }

  static void showInfo(BuildContext context, String message) {
    show(
      context: context,
      title: 'Informasi',
      message: message,
      type: ContentType.help,
      backgroundColor: AppColor.primaryLight.color,
    );
  }

  static void showWarning(BuildContext context, String message) {
    show(
      context: context,
      title: 'Peringatan!',
      message: message,
      type: ContentType.warning,
      backgroundColor: AppColor.accent.color,
    );
  }

  static Color _getColorByType(ContentType type) {
    switch (type) {
      case ContentType.success:
        return AppColor.success.color;
      case ContentType.failure:
        return AppColor.error.color;
      case ContentType.warning:
        return AppColor.accent.color;
      case ContentType.help:
        return AppColor.primaryLight.color;
      default:
        return AppColor.primaryLight.color;
    }
  }
}

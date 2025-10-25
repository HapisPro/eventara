import 'package:eventara/core/app_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarUtils {
  static String _formatDate(DateTime dateTime) {
    final utc = dateTime.toUtc();
    return DateFormat("yyyyMMdd'T'HHmmss'Z'").format(utc);
  }

  static Future<void> addToGoogleCalendar({
    required BuildContext context,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    String? description,
    String? location,
  }) async {
    final encodedTitle = Uri.encodeComponent(title);
    final encodedDescription = Uri.encodeComponent(description ?? '');
    final encodedLocation = Uri.encodeComponent(location ?? '');
    final start = _formatDate(startTime);
    final end = _formatDate(endTime);

    // Build URL with proper encoding
    final url =
        'https://calendar.google.com/calendar/u/0/r/eventedit?text=$encodedTitle'
        '&dates=$start/$end'
        '&details=$encodedDescription'
        '&location=$encodedLocation';

    final uri = Uri.parse(url);

    try {
      // Try with platformDefaultBehavior mode first (works better on Android)
      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

        if (launched) {
          if (context.mounted) {
            AppSnackBarWidget.showSuccess(
              context,
              "Membuka Google Calendar...",
            );
          }
          return;
        }
      }

      // Fallback: Try with externalApplication mode
      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          if (context.mounted) {
            AppSnackBarWidget.showSuccess(
              context,
              "Membuka Google Calendar...",
            );
          }
          return;
        }
      }

      // Fallback: Try shorter URL (without description and location)
      final shortUrl =
          'https://calendar.google.com/calendar/u/0/r/eventedit?text=$encodedTitle&dates=$start/$end';
      final shortUri = Uri.parse(shortUrl);

      if (await canLaunchUrl(shortUri)) {
        final launched = await launchUrl(
          shortUri,
          mode: LaunchMode.platformDefault,
        );

        if (launched) {
          if (context.mounted) {
            AppSnackBarWidget.showSuccess(
              context,
              "Membuka Google Calendar...",
            );
          }
          return;
        }
      }

      // If all attempts fail, show error
      if (context.mounted) {
        AppSnackBarWidget.showError(
          context,
          "Tidak dapat membuka Google Calendar. Pastikan aplikasi browser atau Google Calendar terinstall.",
        );
      }
    } catch (e) {
      debugPrint("Error membuka Google Calendar: $e");
      if (context.mounted) {
        AppSnackBarWidget.showError(
          context,
          "Terjadi kesalahan saat membuka Google Calendar.",
        );
      }
    }
  }
}

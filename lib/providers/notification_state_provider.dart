import 'package:eventara/data/services/local_notification_service.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';


class NotificationStateProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;
  NotificationStateProvider(this.flutterNotificationService);

  final Map<String, bool> _notificationStates = {};
  bool _initialized = false;

  bool isNotificationActive(String eventId) {
    return _notificationStates[eventId] ?? false;
  }

  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (var key in keys) {
      if (key.startsWith('notif_')) {
        _notificationStates[key.replaceFirst('notif_', '')] =
            prefs.getBool(key) ?? false;
      }
    }
    _initialized = true;
    notifyListeners();
  }

  Future<void> toggleNotificationForEvent({
    required String eventId,
    required int id,
    required String title,
    required String body,
    required DateTime eventDateTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final isActive = _notificationStates[eventId] ?? false;

    if (isActive) {
      // Batalkan notifikasi
      await flutterNotificationService.cancelNotification(id);
      _notificationStates[eventId] = false;
      await prefs.setBool('notif_$eventId', false);
    } else {
      // Jadwalkan notifikasi
      await flutterNotificationService.scheduleNotificationOneDayBeforeEvent(
        id: id,
        title: title,
        body: body,
        eventDateTime: eventDateTime,
      );
      _notificationStates[eventId] = true;
      await prefs.setBool('notif_$eventId', true);
    }

    notifyListeners();
  }
}

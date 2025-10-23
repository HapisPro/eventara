import 'package:eventara/data/models/event_model.dart';

class EventFilter {
  static List<EventModel> filterUpcoming(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) {
      return e.startTime.isAfter(now);
    }).toList();
  }

  static List<EventModel> filterLive(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) {
      final start = e.startTime;
      final end = e.startTime.add(const Duration(hours: 4));
      return now.isAfter(start) && now.isBefore(end);
    }).toList();
  }

  static List<EventModel> filterEnded(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) {
      final end = e.startTime.add(const Duration(hours: 12));
      return now.isAfter(end);
    }).toList();
  }

  static List<EventModel> search(List<EventModel> events, String query) {
    if (query.isEmpty) return events;
    final lowerQuery = query.toLowerCase();
    return events
        .where(
          (e) =>
              e.title.toLowerCase().contains(lowerQuery) ||
              e.organizer.toLowerCase().contains(lowerQuery) ||
              e.city.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}

import 'package:eventara/data/models/event_model.dart';

class EventFilter {
  static List<EventModel> filterUpcoming(List<EventModel> events) {
    final now = DateTime.now();
    final list = events
        .where((e) => e.startTime.toLocal().isAfter(now))
        .toList();
    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  static List<EventModel> filterLive(List<EventModel> events) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));

    final list = events.where((e) {
      final start = e.startTime.toLocal();
      final end = e.endTime.toLocal();

      final startsToday =
          !start.isBefore(todayStart) && start.isBefore(tomorrowStart);
      final happeningNow = (!now.isBefore(start)) && now.isBefore(end);

      return startsToday && happeningNow;
    }).toList();

    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  static List<EventModel> filterEnded(List<EventModel> events) {
    final now = DateTime.now();
    final list = events.where((e) {
      final end = e.endTime.toLocal();
      return now.isAfter(end);
    }).toList();
    list.sort((a, b) => b.startTime.compareTo(a.startTime));
    return list;
  }

  static List<EventModel> filterByDate(
    List<EventModel> events,
    DateTime targetDate,
  ) {
    final dayStart = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    final nextDayStart = dayStart.add(const Duration(days: 1));

    final list = events.where((e) {
      final start = e.startTime.toLocal();
      return !start.isBefore(dayStart) && start.isBefore(nextDayStart);
    }).toList();

    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  static List<EventModel> filterByDateRange(
    List<EventModel> events,
    DateTime startDate,
    DateTime endDate,
  ) {
    final rangeStart = DateTime(startDate.year, startDate.month, startDate.day);
    final rangeEndExclusive = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    ).add(const Duration(days: 1));

    final list = events.where((e) {
      final start = e.startTime.toLocal();
      return !start.isBefore(rangeStart) && start.isBefore(rangeEndExclusive);
    }).toList();

    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  static List<EventModel> filterToday(List<EventModel> events) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));

    final list = events.where((e) {
      final start = e.startTime.toLocal();
      return !start.isBefore(todayStart) && start.isBefore(tomorrowStart);
    }).toList();

    list.sort((a, b) => a.startTime.compareTo(b.startTime));
    return list;
  }

  static List<EventModel> filterThisWeek(List<EventModel> events) {
    final now = DateTime.now();
    final weekStart = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final weekEndExclusive = weekStart.add(const Duration(days: 7));
    return filterByDateRange(
      events,
      weekStart,
      weekEndExclusive.subtract(const Duration(days: 1)),
    );
  }

  static List<EventModel> filterThisMonth(List<EventModel> events) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final nextMonthStart = (now.month == 12)
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, now.month + 1, 1);
    return filterByDateRange(
      events,
      monthStart,
      nextMonthStart.subtract(const Duration(days: 1)),
    );
  }

  static List<EventModel> search(List<EventModel> events, String query) {
    if (query.isEmpty) return events;
    final q = query.toLowerCase();
    return events.where((e) {
      return e.title.toLowerCase().contains(q) ||
          e.organizer.toLowerCase().contains(q) ||
          e.city.toLowerCase().contains(q) ||
          e.province.toLowerCase().contains(q) ||
          e.description.toLowerCase().contains(q);
    }).toList();
  }

  static List<EventModel> filterByLocation(
    List<EventModel> events,
    String location,
  ) {
    if (location.isEmpty) return events;
    final q = location.toLowerCase();
    return events.where((e) {
      return e.city.toLowerCase().contains(q) ||
          e.province.toLowerCase().contains(q);
    }).toList();
  }

  static List<EventModel> filterByOrganizer(
    List<EventModel> events,
    String organizer,
  ) {
    if (organizer.isEmpty) return events;
    final q = organizer.toLowerCase();
    return events.where((e) => e.organizer.toLowerCase().contains(q)).toList();
  }
}

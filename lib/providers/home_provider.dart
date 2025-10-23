import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/event_filter.dart';
import 'package:eventara/data/services/event_service.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  final _eventService = EventService();

  String? userName;
  List<EventModel> liveEvents = [];
  List<EventModel> upcomingEvents = [];
  List<EventModel> allEvents = [];
  bool isLoading = false;

  Future<void> loadHomeData() async {
    try {
      isLoading = true;
      notifyListeners();

      allEvents = await _eventService.getApprovedEvents();

      liveEvents = EventFilter.filterLive(allEvents);
      upcomingEvents = EventFilter.filterUpcoming(allEvents);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      liveEvents = EventFilter.filterLive(allEvents);
      upcomingEvents = EventFilter.filterUpcoming(allEvents);
    } else {
      final filtered = EventFilter.search(allEvents, query);
      liveEvents = EventFilter.filterLive(filtered);
      upcomingEvents = EventFilter.filterUpcoming(filtered);
    }
    notifyListeners();
  }
}

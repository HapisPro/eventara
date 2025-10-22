import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/event_service.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  final _eventService = EventService();

  String? userName;
  List<EventModel> liveEvents = [];
  List<EventModel> upcomingEvents = [];
  bool isLoading = false;

  Future<void> loadHomeData() async {
    try {
      isLoading = true;
      notifyListeners();
      
      final allEvents = await _eventService.getApprovedEvents();

      liveEvents = _eventService.filterLive(allEvents);
      upcomingEvents = _eventService.filterUpcoming(allEvents);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
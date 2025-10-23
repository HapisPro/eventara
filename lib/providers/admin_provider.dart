import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/event_service.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  final EventService _eventService = EventService();

  List<EventModel> _pendingEvents = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<EventModel> get pendingEvents => _pendingEvents;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPendingEvents() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _pendingEvents = await _eventService.getPendingEvents();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> approveEvent(String eventId) async {
    try {
      await _eventService.approveEvent(eventId);
      _pendingEvents.removeWhere((event) => event.id == eventId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> rejectEvent(String eventId) async {
    try {
      await _eventService.rejectEvent(eventId);
      _pendingEvents.removeWhere((event) => event.id == eventId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}

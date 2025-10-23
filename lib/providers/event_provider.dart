import 'dart:io';

import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:eventara/data/state/event_state.dart';

class EventProvider extends ChangeNotifier {
  final EventService _service = EventService();

  EventState _state = EventInitial();
  EventState get state => _state;

  Future<void> addEventToFireStore(EventModel event, {File? imageFile}) async {
    _state = EventLoading();
    notifyListeners();

    try {
      await _service.addImageToSupabase(event, imageFile: imageFile);
      _state = EventSuccess("Event berhasil ditambahkan");
    } catch (e) {
      _state = EventError("Gagal menambahkan event: ${e.toString()}");
    }

    notifyListeners();
  }

  void reset() {
    _state = EventInitial();
    notifyListeners();
  }
}

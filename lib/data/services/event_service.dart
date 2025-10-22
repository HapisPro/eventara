import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventara/data/models/event_model.dart';

import 'dart:io';
import 'supabase_storage_service.dart';

class EventService {
  final _firestore = FirebaseFirestore.instance;
  final _storage = SupabaseStorageService();

  //add image to supabase storage
  Future<void> addImageToSupabase(EventModel event, {File? imageFile}) async {
    String? imageUrl = event.imageUrl;

    if (imageFile != null) {
      try {
        imageUrl = await _storage.uploadImage(imageFile);
      } catch (e) {
        rethrow;
      }
    }

    final docData = event.toMap();
    if (imageUrl != null) {
      docData['imageUrl'] = imageUrl;
    }

    await _firestore.collection('events').add(docData);
  }

  Future<List<EventModel>> getApprovedEvents() async {
    final snapshot = await _firestore
        .collection('events')
        .where('status', isEqualTo: 'approve')
        .get();

    return snapshot.docs
        .map((doc) => EventModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  List<EventModel> filterUpcoming(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) => e.date.isAfter(now)).toList();
  }

  List<EventModel> filterLive(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) {
      final start = e.startTime;
      final end = e.startTime.add(const Duration(hours: 6));
      return now.isAfter(start) && now.isBefore(end);
    }).toList();
  }
}

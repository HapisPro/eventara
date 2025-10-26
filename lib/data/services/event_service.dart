import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventara/data/models/event_model.dart';

import 'supabase_storage_service.dart';

class EventService {
  final _firestore = FirebaseFirestore.instance;
  final _storage = SupabaseStorageService();

  Future<void> addImageToSupabase(EventModel event, {File? imageFile}) async {
    String? imageUrl = event.imageUrl;

    if (imageFile != null) {
      imageUrl = await _storage.uploadImage(imageFile);
    }

    final docData = event.toMap();
    if (imageUrl != null) docData['imageUrl'] = imageUrl;

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

  Future<List<EventModel>> getPendingEvents() async {
    final snapshot = await _firestore
        .collection('events')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => EventModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> approveEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).update({
      'status': 'approve',
      'approvedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> rejectEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).update({
      'status': 'rejected',
      'rejectedAt': FieldValue.serverTimestamp(),
    });
  }
}

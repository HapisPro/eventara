import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/database_helper.dart';

class BookmarkService {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBookmark({
    required String userId,
    required String eventId,
  }) async {
    await _dbHelper.addBookmark(userId: userId, eventId: eventId);
  }

  Future<void> removeBookmark({
    required String userId,
    required String eventId,
  }) async {
    await _dbHelper.removeBookmark(userId: userId, eventId: eventId);
  }

  Future<void> toggleBookmark({
    required String userId,
    required String eventId,
  }) async {
    final isBookmarked = await _dbHelper.isEventBookmarked(
      userId: userId,
      eventId: eventId,
    );

    if (isBookmarked) {
      await _dbHelper.removeBookmark(userId: userId, eventId: eventId);
    } else {
      await _dbHelper.addBookmark(userId: userId, eventId: eventId);
    }
  }

  Future<bool> isBookmarked({
    required String userId,
    required String eventId,
  }) async {
    return await _dbHelper.isEventBookmarked(userId: userId, eventId: eventId);
  }

  Future<List<EventModel>> getUserBookmarks(String userId) async {
    try {
      final eventIds = await _dbHelper.getUserBookmarkedEventIds(userId);

      if (eventIds.isEmpty) {
        return [];
      }

      final List<EventModel> bookmarkedEvents = [];

      for (int i = 0; i < eventIds.length; i += 10) {
        final batchIds = eventIds.skip(i).take(10).toList();

        final snapshot = await _firestore
            .collection('events')
            .where(FieldPath.documentId, whereIn: batchIds)
            .get();

        for (var doc in snapshot.docs) {
          bookmarkedEvents.add(EventModel.fromMap(doc.data(), doc.id));
        }
      }

      final sortedEvents = <EventModel>[];
      for (var eventId in eventIds) {
        final event = bookmarkedEvents.firstWhere(
          (e) => e.id == eventId,
          orElse: () => bookmarkedEvents.first,
        );
        if (!sortedEvents.contains(event)) {
          sortedEvents.add(event);
        }
      }

      return sortedEvents;
    } catch (e) {
      throw Exception('Failed to load bookmarks: $e');
    }
  }

  Future<int> getBookmarkCount(String userId) async {
    return await _dbHelper.getBookmarkCount(userId);
  }

  Future<void> clearUserBookmarks(String userId) async {
    await _dbHelper.clearUserBookmarks(userId);
  }
}

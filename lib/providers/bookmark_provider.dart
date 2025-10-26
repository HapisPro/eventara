import 'package:eventara/data/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/services/bookmark_service.dart';

class BookmarkProvider extends ChangeNotifier {
  final BookmarkService _service;
  List<EventModel> _bookmarks = [];
  Set<String> _bookmarkedEventIds = {};
  bool _isLoading = false;
  String? _errorMessage;

  List<EventModel> get bookmarks => _bookmarks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  BookmarkProvider(this._service);

  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> loadBookmarks() async {
    final userId = _currentUserId;
    if (userId == null) {
      _bookmarks = [];
      _bookmarkedEventIds.clear();
      _errorMessage = 'User not logged in';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _bookmarks = await _service.getUserBookmarks(userId);
      _bookmarkedEventIds = _bookmarks
          .where((e) => e.id != null)
          .map((e) => e.id!)
          .toSet();
    } catch (e) {
      _errorMessage = e.toString();
      _bookmarks = [];
      _bookmarkedEventIds.clear();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleBookmark(EventModel event) async {
    final userId = _currentUserId;
    if (userId == null || event.id == null) {
      return false;
    }

    try {
      final wasBookmarked = _bookmarkedEventIds.contains(event.id);

      if (wasBookmarked) {
        _bookmarkedEventIds.remove(event.id);
        _bookmarks.removeWhere((e) => e.id == event.id);
      } else {
        _bookmarkedEventIds.add(event.id!);
        _bookmarks.insert(0, event);
      }
      notifyListeners();

      await _service.toggleBookmark(userId: userId, eventId: event.id!);

      return true;
    } catch (e) {
      if (_bookmarkedEventIds.contains(event.id)) {
        _bookmarkedEventIds.remove(event.id);
        _bookmarks.removeWhere((e) => e.id == event.id);
      } else {
        _bookmarkedEventIds.add(event.id!);
        _bookmarks.insert(0, event);
      }

      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  bool isBookmarked(String eventId) {
    return _bookmarkedEventIds.contains(eventId);
  }

  Future<bool> isBookmarkedFromDb(String eventId) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    try {
      return await _service.isBookmarked(userId: userId, eventId: eventId);
    } catch (e) {
      return false;
    }
  }

  Future<int> getBookmarkCount() async {
    final userId = _currentUserId;
    if (userId == null) return 0;

    try {
      return await _service.getBookmarkCount(userId);
    } catch (e) {
      return 0;
    }
  }

  Future<void> clearAll() async {
    final userId = _currentUserId;
    if (userId == null) return;

    try {
      await _service.clearUserBookmarks(userId);
      _bookmarks.clear();
      _bookmarkedEventIds.clear();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadBookmarks();
  }

  void clearLocalState() {
    _bookmarks.clear();
    _bookmarkedEventIds.clear();
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}

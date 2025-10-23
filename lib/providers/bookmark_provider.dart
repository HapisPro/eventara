import 'package:eventara/data/models/event_model.dart';
import 'package:flutter/material.dart';
import '../data/services/bookmark_service.dart';

class BookmarkProvider extends ChangeNotifier {
  final BookmarkService _service;
  List<EventModel> _bookmarks = [];

  List<EventModel> get bookmarks => _bookmarks;

  BookmarkProvider(this._service) {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    _bookmarks = await _service.getBookmarks();
    notifyListeners();
  }

  Future<void> toggleBookmark(EventModel event) async {
    final existingIndex = _bookmarks.indexWhere((e) => e.id == event.id);

    if (existingIndex != -1) {
      _bookmarks.removeAt(existingIndex);
    } else {
      _bookmarks.add(event);
    }

    await _service.saveBookmarks(_bookmarks);
    notifyListeners();
  }

  bool isBookmarked(String id) {
    return _bookmarks.any((e) => e.id == id);
  }

  Future<void> clearAll() async {
    await _service.clearBookmarks();
    _bookmarks.clear();
    notifyListeners();
  }
}

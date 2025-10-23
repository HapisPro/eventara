import 'dart:convert';
import 'package:eventara/data/models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String _keyBookmarks = "BOOKMARK_EVENTS";

  Future<void> saveBookmarks(List<EventModel> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = bookmarks.map((e) => e.toMap()).toList();
    await prefs.setString(_keyBookmarks, jsonEncode(encoded));
  }

  Future<List<EventModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyBookmarks);
    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded
        .map(
          (e) =>
              EventModel.fromMap(Map<String, dynamic>.from(e), e['id'] ?? ''),
        )
        .toList();
  }

  Future<void> clearBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyBookmarks);
  }
}

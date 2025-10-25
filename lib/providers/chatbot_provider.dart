import 'package:eventara/data/models/event_model.dart';
import 'package:eventara/data/services/event_service.dart';
import 'package:eventara/data/services/gemini_service.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatbotProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final EventService _eventService = EventService();

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  List<EventModel> _approvedEvents = [];

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatbotProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _messages.add(
      ChatMessage(
        text: _geminiService.getInitialGreeting(),
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    await _loadApprovedEvents();
  }

  Future<void> _loadApprovedEvents() async {
    try {
      _approvedEvents = await _eventService.getApprovedEvents();
    } catch (e) {
      debugPrint('Error loading approved events: $e');
    }
  }

  List<Map<String, dynamic>> _eventsToRagContext() {
    return _approvedEvents.map((event) {
      return {
        'title': event.title,
        'date': event.startTime.toString().split(' ')[0],
        'location': '${event.city}, ${event.province}',
        'description': event.description,
        'status': 'approve',
        'organizer': event.organizer,
      };
    }).toList();
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        text: message.trim(),
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      await _loadApprovedEvents();

      final ragContext = _eventsToRagContext();

      final response = await _geminiService.sendMessage(message, ragContext);

      _messages.add(
        ChatMessage(text: response, isUser: false, timestamp: DateTime.now()),
      );
    } catch (e) {
      debugPrint('Error in chatbot: $e');
      _messages.add(
        ChatMessage(
          text: 'Maaf, terjadi kesalahan. Silakan coba lagi.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    _messages.add(
      ChatMessage(
        text: _geminiService.getInitialGreeting(),
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> refreshEvents() async {
    await _loadApprovedEvents();
    notifyListeners();
  }
}

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
    // Add initial greeting
    _messages.add(
      ChatMessage(
        text: _geminiService.getInitialGreeting(),
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    // Load approved events
    await _loadApprovedEvents();
  }

  Future<void> _loadApprovedEvents() async {
    try {
      _approvedEvents = await _eventService.getApprovedEvents();
    } catch (e) {
      debugPrint('Error loading approved events: $e');
    }
  }

  /// Convert EventModel to Map for RAG context
  List<Map<String, dynamic>> _eventsToRagContext() {
    return _approvedEvents.map((event) {
      return {
        'title': event.title,
        'date': event.startTime.toString().split(' ')[0], // YYYY-MM-DD
        'location': '${event.city}, ${event.province}',
        'description': event.description,
        'status': 'approve', // All events from getApprovedEvents are approved
        'organizer': event.organizer,
      };
    }).toList();
  }

  /// Send a message to the chatbot
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    _messages.add(
      ChatMessage(
        text: message.trim(),
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    // Set loading state
    _isLoading = true;
    notifyListeners();

    try {
      // Reload events to get latest data
      await _loadApprovedEvents();

      // Get RAG context
      final ragContext = _eventsToRagContext();

      // Get response from Gemini
      final response = await _geminiService.sendMessage(message, ragContext);

      // Add bot response
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

  /// Clear chat history
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

  /// Refresh events data
  Future<void> refreshEvents() async {
    await _loadApprovedEvents();
    notifyListeners();
  }
}

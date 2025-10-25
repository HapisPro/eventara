import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyA9N2Y8b-jE_Xia0NqSzg56W59FU99mE4U';

  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
  }

  /// Build RAG context from events
  String _buildRagContext(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return "Belum ada event yang tersedia saat ini.";
    }

    final buffer = StringBuffer();
    buffer.writeln("Daftar Event yang Tersedia:\n");

    for (var event in events) {
      final title = event['title'] ?? 'Tanpa Judul';
      final date = event['date'] ?? '';
      final location = event['location'] ?? '';
      final description = event['description'] ?? '';
      final status = event['status'] ?? 'pending';

      if (status == 'approve') {
        buffer.writeln("• $date — $title");
        if (location.isNotEmpty) {
          buffer.writeln("  Lokasi: $location");
        }
        if (description.isNotEmpty) {
          buffer.writeln("  Detail: $description");
        }
        buffer.writeln();
      }
    }

    return buffer.toString();
  }

  /// Get system instruction with RAG context
  String _getSystemInstruction(String ragContext) {
    return '''
Peran:
Kamu adalah Asisten Seputar Acara Budaya Indonesia di sebuah aplikasi CRUD yang menampilkan event dan festival budaya Indonesia. Pengguna bisa mengunggah event, lalu admin akan memverifikasi sebelum tampil publik.

Sumber RAG (konteks eksternal):

$ragContext

Gunakan data ini untuk menjawab pertanyaan tentang event. Jika tidak ada, katakan "belum ditemukan".

Aturan Jawaban:

1. Bahasa Indonesia, ramah, ringkas, sopan.

2. Jangan mengarang data; gunakan hanya yang ada di RAG.

3. Jika pengguna menanyakan cara melihat event, jawab:
"Ke halaman home -> cek bagian event yang akan datang/live event."

4. Jika tanya status event → jelaskan bahwa event akan muncul setelah diverifikasi admin.

5. Jika tanya cara submit → jelaskan langkah CRUD (unggah, isi detail, kirim, tunggu verifikasi admin).

6. Jika tidak menemukan event → sarankan cek ejaan atau lihat di halaman home.

7. Jika pengguna hanya menyapa ("halo", "hai", "apa kabar"), balas dengan sapaan ramah yang juga memperkenalkan peranmu.

8. Selalu berikan jawaban yang informatif namun singkat dan mudah dipahami.

9. Jika pengguna bertanya di luar konteks event budaya Indonesia, arahkan kembali ke topik event budaya.
''';
  }

  /// Send a message and get response with RAG context
  Future<String> sendMessage(
    String message,
    List<Map<String, dynamic>> events,
  ) async {
    try {
      final ragContext = _buildRagContext(events);
      final systemInstruction = _getSystemInstruction(ragContext);

      // Create a new model with system instruction for this context
      final contextModel = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: _apiKey,
        systemInstruction: Content.text(systemInstruction),
      );

      final contextChat = contextModel.startChat();
      final response = await contextChat.sendMessage(Content.text(message));

      return response.text ?? 'Maaf, saya tidak dapat memproses pesan Anda.';
    } catch (e) {
      debugPrint('Error sending message to Gemini: $e');

      // Check for API key error
      if (e.toString().contains('API key') ||
          e.toString().contains('401') ||
          e.toString().contains('apiKey')) {
        return 'Error: API key belum dikonfigurasi. Silakan tambahkan API key Gemini Anda di file gemini_service.dart';
      }

      return 'Maaf, terjadi kesalahan dalam memproses pesan Anda. Silakan coba lagi.';
    }
  }

  /// Get initial greeting
  String getInitialGreeting() {
    return 'Halo! Saya asisten Eventara yang siap membantu Anda menemukan informasi seputar event dan festival budaya Indonesia. Ada yang bisa saya bantu?';
  }
}

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseStorageService {
  final _client = Supabase.instance.client;

  final _bucket = 'event-images';
  final _uuid = const Uuid();

  Future<String> uploadImage(File file) async {
    final ext = file.path.split('.').last;
    final fileName = '${_uuid.v4()}.$ext';
    final path = fileName;

    await _client.storage.from(_bucket).upload(path, file);
    final publicUrl = _client.storage.from(_bucket).getPublicUrl(path);
    return publicUrl;
  }
}

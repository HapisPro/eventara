import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventara/data/models/user_model.dart';
import 'package:eventara/data/state/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  UserState _state = UserInitial();
  UserState get state => _state;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> fetchUser() async {
    _state = UserLoading();
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        _state = UserError("Pengguna belum login");
        notifyListeners();
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        _state = UserError("Data pengguna tidak ditemukan");
        notifyListeners();
        return;
      }

      final userData = UserModel.fromMap(doc.data()!);
      _state = UserLoaded(userData);
    } catch (e) {
      _state = UserError("Gagal memuat profil: $e");
    }

    notifyListeners();
  }

  Future<void> updateProfilePicture(File imageFile) async {
    try {
      _state = UserLoading();
      notifyListeners();

      final user = _auth.currentUser;
      if (user == null) {
        _state = UserError("Pengguna belum login");
        notifyListeners();
        return;
      }

      final supabase = Supabase.instance.client;
      final fileName = "profile_${user.uid}.jpg";

      try {
        await supabase.storage.from('profile_pics').remove([fileName]);
      } catch (_) {}

      await supabase.storage
          .from('profile_pics')
          .upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = supabase.storage
          .from('profile_pics')
          .getPublicUrl(fileName);
      final cacheBustedUrl =
          "$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}";

      await _firestore.collection('users').doc(user.uid).update({
        'photoUrl': cacheBustedUrl,
      });

      final updatedDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();
      final updatedUser = UserModel.fromMap(updatedDoc.data()!);
      _state = UserLoaded(updatedUser);
    } catch (e) {
      _state = UserError("Gagal mengupdate foto profil: $e");
    }
    notifyListeners();
  }
}

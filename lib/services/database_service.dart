import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_app/models/user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> saveUserFirebase({
    required String username,
    required String email,
    File? file,
    PlatformFile? imageUrl,
  }) async {
    String uid = _auth.currentUser?.uid ?? '';
    if (uid.isEmpty) {
      throw FirebaseException(
        message: 'Usuario no autenticado',
        code: 'user_not_authenticated',
        plugin: '',
      );
    }

    if (kIsWeb) {
      // SAVE IMAGE WEB
      if (imageUrl != null &&
          imageUrl.bytes != null &&
          imageUrl.bytes!.isNotEmpty) {
        final storageRef = _storage.ref().child('user_images').child(uid);
        final contentType = _getContentType(imageUrl.name);
        final metadata = SettableMetadata(contentType: contentType);

        try {
          await storageRef.putData(
              Uint8List.fromList(imageUrl.bytes!), metadata);
          final image = await storageRef.getDownloadURL();
          UserProfile user = UserProfile(
              uid: uid, email: email, username: username, image: image);

          final userMap = user.toMap();
          await _db.collection('Users').doc(uid).set(userMap);
        } catch (e) {
          print('Error al subir la imagen en la web: $e');
          throw FirebaseException(
            message: 'Error al subir la imagen en la web',
            code: 'image_upload_error',
            plugin: '',
          );
        }
      } else {
        UserProfile user =
            UserProfile(uid: uid, email: email, username: username, image: '');
        final userMap = user.toMap();
        await _db.collection('Users').doc(uid).set(userMap);
      }
    } else {
      // SAVE IMAGE MOBILE
      if (file != null) {
        final storageRef = _storage.ref().child('user_images').child(uid);
        final uploadTask = storageRef.putFile(file);
        final snapshot = await uploadTask.whenComplete(() => null);
        final image = await snapshot.ref.getDownloadURL();
        UserProfile user = UserProfile(
            uid: uid, email: email, username: username, image: image);

        final userMap = user.toMap();
        await _db.collection('Users').doc(uid).set(userMap);
      } else {
        UserProfile user =
            UserProfile(uid: uid, email: email, username: username, image: '');
        final userMap = user.toMap();
        await _db.collection('Users').doc(uid).set(userMap);
      }
    }
  }

  Future<UserProfile> getUserFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      throw FirebaseException(
        message: 'Error fetching user profile',
        code: 'user_profile_error',
        plugin: '',
      );
    }
  }

  String _getContentType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream'; // Tipo por defecto si no se puede identificar
    }
  }
}


/**
 * 
 * /*
rules_version = '2';

// Craft rules based on data in your Firestore database
// allow write: if firestore.get(
//    /databases/(default)/documents/users/$(request.auth.uid)).data.isAdmin;
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if true;
    }
  }
}
 */
 */
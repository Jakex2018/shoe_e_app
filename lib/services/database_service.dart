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
    String uid = _auth.currentUser!.uid;

    if (kIsWeb) {
      //SAVE IMAGE WEB

      if (imageUrl != null) {
        final storageRef = _storage.ref().child('user_images').child(uid);
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        await storageRef.putData(Uint8List.fromList(imageUrl.bytes!), metadata);
        final image = await storageRef.getDownloadURL();
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
    } else {
      //SAVE IMAGE MOBILE
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
          plugin: '');
    }
  }
}


/*
service firebase.storage {
  match /{allPaths=**} {
    allow read,write: if request.auth!=null
  }
}
 */

/*
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> saveUserFirebase({
    required String username,
    required String email,
    File? file,
  }) async {
    String uid = _auth.currentUser!.uid;
    String? imageUrlToStore;
    if (kIsWeb && webFile != null) {
      final reader = html.FileReader();
      reader
          .readAsArrayBuffer(webFile); // Lee el archivo como un array de bytes
      await reader.onLoadEnd.first; // Espera a que termine de leer

      final bytes = reader.result as Uint8List; // Obtiene los bytes del archivo
      final storageRef = _storage.ref().child('user_images').child(uid);
      final uploadTask = storageRef.putData(bytes); // Sube los datos
      final snapshot = await uploadTask; // Espera la finalización
      imageUrlToStore = await snapshot.ref.getDownloadURL();
    } else if (file != null) {
      final storageRef = _storage.ref().child('user_images').child(uid);
      final uploadTask = storageRef.putFile(file); // Sube el archivo
      final snapshot = await uploadTask; // Espera la finalización
      imageUrlToStore =
          await snapshot.ref.getDownloadURL(); // Obtén la URL de la imagen
    } else if (imageUrl != null) {
      imageUrlToStore = imageUrl; // Usa la URL directamente
    }
    UserProfile user = UserProfile(
        uid: uid, email: email, username: username, image: imageUrlToStore!);

    final userMap = user.toMap();

    await _db.collection('Users').doc(uid).set(userMap);
    print("Datos del usuario guardados exitosamente.");
  }

  Future<UserProfile> getUserFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      throw FirebaseException(
          message: 'Error fetching user profile',
          code: 'user_profile_error',
          plugin: '');
    }
  }
}


 */



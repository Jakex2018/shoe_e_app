import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> saveUserFirebase({
    required String username,
    required String email,
    required File file,
  }) async {
    String uid = _auth.currentUser!.uid;

    //GET IMAGE

    final storageRef = _storage.ref().child('user_images').child(uid);
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    final image = await snapshot.ref.getDownloadURL();

    UserProfile user =
        UserProfile(uid: uid, email: email, username: username, image: image);

    final userMap = user.toMap();

    await _db.collection('Users').doc(uid).set(userMap);
  }

  Future<UserProfile?> getUserFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();

      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      return null;
    }
  }
}

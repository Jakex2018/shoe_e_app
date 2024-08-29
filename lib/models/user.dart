import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;

  final String email;
  final String username;
  final String image;

  UserProfile(
      {required this.uid, required this.email, required this.username,required this.image});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
        uid: doc['uid'],
        email: doc['email'],
        username: doc['username'],
        image: doc['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'image': image,
    };
  }
}

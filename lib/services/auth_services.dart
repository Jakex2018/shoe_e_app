import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginServices {
  final _auth = FirebaseAuth.instance;
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentId() => _auth.currentUser!.uid;
  Future<UserCredential?> loginUser(
      String email, String password, context) async {
    try {
      final loginCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (loginCredential.user != null) {
        var snackbar = const SnackBar(
          content:
              Text('Login Succesfull', style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 50),
          backgroundColor: Color.fromARGB(255, 12, 165, 53),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'La dirección de correo electrónico no está registrada.';
      } else if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta.';
      } else {
        message = 'Ocurrió un error durante el inicio de sesión.';
      }
      var snackbar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.only(bottom: 50, left: 60, right: 50),
        backgroundColor: const Color.fromARGB(255, 12, 165, 53),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    return null;
  }

  Future<UserCredential?> registerUser(
      String email, String password, context) async {
    try {
      final registerCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (registerCredential.user != null) {
        var snackbar = const SnackBar(
          content: Text('Register Successfulyy',
              style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 50, left: 60, right: 50),
          backgroundColor: Color.fromARGB(255, 12, 165, 53),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'La dirección de correo electrónico no está registrada.';
      } else if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta.';
      } else {
        message = 'Ocurrió un error durante el inicio de sesión.';
      }
      var snackbar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.only(bottom: 50, left: 60, right: 50),
        backgroundColor: const Color.fromARGB(255, 12, 165, 53),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    return null;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginServices {
  final _auth = FirebaseAuth.instance;
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentId() => _auth.currentUser!.uid;
  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      final loginCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (loginCredential.user != null) {
        Fluttertoast.showToast(
          msg: "Login Successfull!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1, // 1 second for iOS/Web
          backgroundColor: const Color.fromARGB(255, 6, 174, 73),
          textColor: const Color(0xFff1f1f1),
          fontSize: 16.0,
        );
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
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1, // 1 second for iOS/Web
        backgroundColor: const Color.fromARGB(255, 174, 14, 6),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0,
      );
    }
    return null;
  }

  Future<UserCredential?> registerUser(String email, String password) async {
    try {
      final registerCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (registerCredential.user != null) {
        Fluttertoast.showToast(
          msg: "Register Successfull!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1, // 1 second for iOS/Web
          backgroundColor: const Color.fromARGB(255, 6, 174, 73),
          textColor: const Color(0xFff1f1f1),
          fontSize: 16.0,
        );
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
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1, // 1 second for iOS/Web
        backgroundColor: const Color.fromARGB(255, 174, 14, 6),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0,
      );
    }
    return null;
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}

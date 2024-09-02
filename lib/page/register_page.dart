// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:io';
import 'package:eco_app/services/auth_services.dart';
import 'package:eco_app/services/database_service.dart';
import 'package:eco_app/widget/button_one.dart';
import 'package:eco_app/widget/form_text.dart';
import 'package:eco_app/widget/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final auth = LoginServices();
  final data = DatabaseService();
  File? file;
  File? selectFile;
  void onPicker() async {
    final picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      setState(() {
        file = File(pickerFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void register() async {
      showLoadingCircle(context);
      try {
        await auth.registerUser(_email.text, _password.text);

        FutureBuilder(
          future: data.saveUserFirebase(
              username: _username.text, email: _email.text, file: file!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              hideLoadingCircle(context);
            }
            return const SizedBox();
          },
        );
        if (mounted) hideLoadingCircle(context);
      } catch (e) {
        if (mounted) hideLoadingCircle(context);
      }
    }

    void clearImage() {
      setState(() {
        file == null;
      });
    }

    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Register Screen'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Text(
                          'To keep connected with us please login with your personal info!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FormText(
                          hintText: 'Username',
                          controller: _username,
                          value: 'Por favor, ingresa un nombre de usuario',
                          fieldType: FieldType.username,
                          suffix: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormText(
                          suffix: false,
                          fieldType: FieldType.email,
                          hintText: 'Email Adress',
                          controller: _email,
                          value: 'Por favor, ingresa un correo valido',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormText(
                          suffix: true,
                          hintText: 'Password',
                          controller: _password,
                          value:
                              'Por favor, ingresa una contraseña maximo 6 caracteres',
                          fieldType: FieldType.password,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: onPicker,
                                child: const Row(
                                  children: [
                                    Icon(Icons.image),
                                    Text('Select Image'),
                                  ],
                                )),
                            CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 30,
                              child: file != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        file!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(
                                      'No Image',
                                      style: TextStyle(fontSize: 7),
                                    ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonOne(title: 'Sign up', onTap: register),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:eco_app/services/auth_services.dart';
import 'package:eco_app/widget/button_one.dart';
import 'package:eco_app/widget/form_text.dart';
import 'package:eco_app/widget/loading_circle.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final authService = LoginServices();

  @override
  Widget build(BuildContext context) {


    void login() async {
      showLoadingCircle(context);
      try {
        await authService.loginUser(_email.text, _password.text);

        if (mounted) hideLoadingCircle(context);
      } catch (e) {
        if (mounted) hideLoadingCircle(context);
      }
    }

    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Login Screen'),
            centerTitle: true,
            automaticallyImplyLeading: false,
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
                        
                          hintText: 'Email Adress',
                          controller: _email,
                          value: 'Por favor, ingresa un email valido',
                          fieldType: FieldType.email,
                          suffix: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormText(
                      
                          fieldType: FieldType.password,
                          hintText: 'Password',
                          controller: _password,
                          value: 'Por favor, ingresa una contraseña valida',
                          suffix: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonOne(title: 'Sign In', onTap: login),
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
                                'Register Now',
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

// ignore_for_file: prefer_final_fields, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FieldType { username, email, password }

class FormText extends StatefulWidget {
  const FormText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.value,
    required this.fieldType,
    required this.suffix,
  });
  final FieldType fieldType;

  final TextEditingController controller;
  final String hintText;
  final String value;
  final bool suffix;

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  bool _obscureText = true;
  bool _obscureEmail = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (widget.fieldType == FieldType.password) {
          if (value!.isEmpty || value.length < 6) {
            return "Minimo 6 caracteres";
          }
        } else if (widget.fieldType == FieldType.email &&
            !value!.contains('@')) {
          return 'El correo debe contener el símbolo @';
        } else {
          return null;
        }
        return null;
      },
      controller: widget.controller,
      obscureText:
          widget.fieldType == FieldType.password ? _obscureText : _obscureEmail,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        suffixIcon: widget.suffix
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: const Icon(Icons.remove_red_eye_sharp))
            : null,
        fillColor: const Color.fromARGB(255, 237, 235, 235),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

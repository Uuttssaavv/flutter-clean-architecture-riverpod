import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextField(
        key: key,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}

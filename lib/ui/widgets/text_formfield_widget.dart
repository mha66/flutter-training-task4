import 'package:flutter/material.dart';

class TextAndFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const TextAndFormField(
      {super.key,
      required this.text,
      required this.controller,
      this.validator,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(color: Color(0xFF6F6666)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          decoration: InputDecoration(

            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.only(left: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFF6F6666),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

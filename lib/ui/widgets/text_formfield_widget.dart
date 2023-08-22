import 'package:flutter/material.dart';

class TextAndFormField extends StatelessWidget {
  final String? text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  const TextAndFormField(
      {super.key,
      this.text,
      required this.controller,
      this.validator,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDADADA),
                  width: 1,
                )
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)) ,
            fillColor: const Color(0xFFF7F8F9),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF8391A1),
              fontWeight: FontWeight.w500,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
      ],
    );
  }
}

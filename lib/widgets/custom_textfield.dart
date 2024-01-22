import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool? obscureText;
  final bool? enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onChanged,
    this.keyboardType,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.obscureText,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFFBDBDBD),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(color: Color(0xFFd1d1d1)),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.white.withOpacity(.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.white.withOpacity(.8)),
        ),
      ),
    );
  }
}
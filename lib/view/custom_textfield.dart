import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.height,
    this.borderColor,
    this.maxLines,
    this.hintStyle,
    this.icon,
    this.expands = false,
    this.isObscure = false,
    this.fillColor,
  });

  final TextEditingController controller;
  final String hintText;
  final double? height;
  final int? maxLines;
  final bool expands;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final bool isObscure;
  final Icon? icon;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      obscureText: isObscure,
      controller: controller,
      maxLines: expands ? null : maxLines ?? 1,
      minLines: expands ? null : maxLines ?? 1,
      expands: expands,
      textAlignVertical: expands
          ? TextAlignVertical.top
          : TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: fillColor,
        suffixIcon: icon,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4A9C9C),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor ?? Color(0xFFCFE8E8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFFCFE8E8),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: borderColor ?? Color(0xFFCFE8E8),
            width: 2,
          ),
        ),
      ),
    );

    if (height != null) {
      return SizedBox(height: height, child: textField);
    }

    return textField;
  }
}

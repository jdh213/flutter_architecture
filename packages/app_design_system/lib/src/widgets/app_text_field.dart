import 'package:flutter/material.dart';

/// 표준 텍스트 입력 필드.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    super.key,
  });

  final String label;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
      ),
    );
  }
}

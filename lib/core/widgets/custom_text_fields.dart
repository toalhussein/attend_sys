import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController workIdController,
    required this.labelText,
    this.obscureText,
  }) : _workIdController = workIdController;

  final TextEditingController _workIdController;
  final String labelText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _workIdController,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      obscureText: obscureText ?? false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
    );
  }
}

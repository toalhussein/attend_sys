import 'package:attend_sys/core/widgets/custom_text_fields.dart';
import 'package:flutter/material.dart';

class PassowordField extends StatelessWidget {
  const PassowordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: CustomTextField(
        workIdController: _passwordController,
        labelText: 'Password',
        obscureText: true,
      ),
    );
  }
}

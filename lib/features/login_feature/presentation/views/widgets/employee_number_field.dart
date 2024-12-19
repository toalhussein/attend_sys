import 'package:attend_sys/core/widgets/custom_text_fields.dart';
import 'package:flutter/material.dart';

class EmployeeNumberField extends StatelessWidget {
  const EmployeeNumberField({
    super.key,
    required TextEditingController workIdController,
  }) : _workIdController = workIdController;

  final TextEditingController _workIdController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      workIdController: _workIdController,
      labelText: 'Employee Number',
    );
  }
}

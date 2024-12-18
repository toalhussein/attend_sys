import 'package:flutter/material.dart';

class InAndOurButton extends StatelessWidget {
  const InAndOurButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });
  final String buttonName;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.green[100]),
      child: Text(
        buttonName,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

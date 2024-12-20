import 'package:attend_sys/core/record.dart';
import 'package:attend_sys/features/user_feature/presentation/views/widgets/in_and_our_button.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 24,
          children: [
            InAndOurButton(
              onPressed: () {
                SignRecord.attendance(context);
              },
              buttonName: 'In',
              buttonColor: Colors.green,
            ),
            InAndOurButton(
              onPressed: () {
                SignRecord.departure(context);
              },
              buttonName: 'Out',
              buttonColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

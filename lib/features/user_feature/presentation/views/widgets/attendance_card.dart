import 'package:attend_sys/core/app_snackbars.dart';
import 'package:attend_sys/core/record.dart';
import 'package:attend_sys/features/user_feature/presentation/views/widgets/in_and_our_button.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InAndOurButton(
              onPressed: () {
                SignRecord.attendance();
                AppSnackbars.showSuccessSnackbar(
                  context,
                  'Success Attendance',
                  'Success Operation',
                );
              },
              buttonName: 'In',
            ),
            InAndOurButton(
              onPressed: () {
                SignRecord.departure();
                AppSnackbars.showSuccessSnackbar(
                  context,
                  'Success Departure',
                  'Success Operation',
                );
              },
              buttonName: 'Out',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

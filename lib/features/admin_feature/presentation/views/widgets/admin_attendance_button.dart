import 'package:flutter/material.dart';

import '../../../../../core/app_snackbars.dart';
import '../../../../../core/record.dart';

class AdminAttendanceButton extends StatelessWidget {
  const AdminAttendanceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Admin Attendance',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    SignRecord.attendance();
                    AppSnackbars.showSuccessSnackbar(
                        context, 'Success Attendance', 'Success Operation');
                  },
                  child: const Text('In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    SignRecord.departure();
                    AppSnackbars.showSuccessSnackbar(
                        context, 'Success Attendance', 'Success Operation');
                  },
                  child: const Text('Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
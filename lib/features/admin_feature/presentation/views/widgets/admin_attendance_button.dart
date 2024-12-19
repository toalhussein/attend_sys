import 'package:flutter/material.dart';
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
                    SignRecord.attendance(context);
                  },
                  child: const Text('In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    SignRecord.departure(context);
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

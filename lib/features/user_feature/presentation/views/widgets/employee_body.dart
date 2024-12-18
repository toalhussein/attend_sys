import 'package:attend_sys/features/user_feature/presentation/views/user_view.dart';
import 'package:attend_sys/features/user_feature/presentation/views/widgets/attendance_card.dart';
import 'package:flutter/material.dart';

class EmployeeBody extends StatelessWidget {
  const EmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome to the Attendance System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please use the buttons below to record your attendance.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            AttendanceCard(),
          ],
        ),
      ),
    );
  }
}

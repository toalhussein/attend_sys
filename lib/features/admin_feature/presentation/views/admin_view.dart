import 'package:attend_sys/core/widgets/custom_app_bar.dart';
import 'package:attend_sys/core/widgets/search_button.dart';
import 'package:attend_sys/features/admin_feature/presentation/views/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'widgets/admin_attendance_button.dart';
import 'widgets/table_calender.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Admin Page',
        actions: [
          SearchButton(),
        ],
      ),
      body: Column(
        children: [
          CustomTableCalender(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                spacing: 32,
                children: [
                  AdminAttendanceButton(),
                  UsersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

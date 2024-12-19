import 'package:attend_sys/features/admin_feature/presentation/views/widgets/table_calender.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/super_admin_app_bar.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/super_admin_drawer.dart';
import 'package:flutter/material.dart';
import '../../admin_feature/presentation/views/widgets/admin_attendance_button.dart';
import '../../admin_feature/presentation/views/widgets/users_list.dart';

class SuperAdminPage extends StatelessWidget {
  const SuperAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SuperAdminAppBar(),
      drawer: SuperAdminDrawer(),
      body: Column(
        children: [
          CustomTableCalender(),
          AdminAttendanceButton(),
          Expanded(child: UsersList()),
        ],
      ),
    );
  }
}

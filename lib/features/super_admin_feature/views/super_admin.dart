// ignore_for_file: library_private_types_in_public_api

import 'package:attend_sys/features/admin_feature/presentation/views/widgets/table_calender.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/super_admin_app_bar.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/super_admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../admin_feature/presentation/views/widgets/admin_attendance_button.dart';
import '../../admin_feature/presentation/views/widgets/users_list.dart';

class SuperAdminPage extends StatelessWidget {
  const SuperAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: const SuperAdminAppBar(),
      drawer: const SuperAdminDrawer(),
      body: Column(
        children: [
          const CustomTableCalender(),
          const AdminAttendanceButton(),
          Expanded(child: UsersList(firestore: firestore)),
        ],
      ),
    );
  }
}

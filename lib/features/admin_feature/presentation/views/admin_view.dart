// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:attend_sys/features/admin_feature/presentation/views/widgets/user_search_delegate.dart';
import 'package:attend_sys/features/admin_feature/presentation/views/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_logout_icon.dart';
import 'widgets/admin_attendance_button.dart';
import 'widgets/table_calender.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final timeFormatter = DateFormat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: UserSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          CustomLogoutIcon()
        ],
      ),
      body: Column(
        children: [
          CustomTableCalender(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AdminAttendanceButton(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  UsersList(firestore: _firestore),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

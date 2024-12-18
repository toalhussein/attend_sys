import 'package:attend_sys/core/calendar_notifier.dart';
import 'package:attend_sys/features/super_admin_feature/views/super_admin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/custom_text_fields.dart';
import '../../../admin_feature/presentation/views/admin_view.dart';
import '../../../user_feature/presentation/views/user_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _workIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  // Future<void> _createUser() async {
  //   await _firestore.collection('users').doc('1').set({
  //     'name': "ahmed",
  //     'role': "employee",
  //     'password': "321",
  //     'work_id': "321",
  //   });
  // }

  Future<void> _navigateToRolePage(String role, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', userId);
    prefs.setString('role', role);

    Widget page;
    switch (role) {
      case 'employee':
        page = const EmployeePage();
        break;
      case 'admin':
        page = const AdminPage();
        break;
      case 'super_admin':
        page = const SuperAdminPage();
        break;
      default:
        _showToast('Invalid role');
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    _showToast('Login successful');
  }

  Future<void> _login() async {
    final String workId = _workIdController.text.trim();
    final String password = _passwordController.text.trim();

    if (workId.isEmpty || password.isEmpty) {
      _showToast('Please enter both Work ID and Password');
      return;
    }

    CustomNotifier.triggerLoading();

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('work_id', isEqualTo: workId)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final userRole = doc['role'] as String?;

        if (userRole == null || userRole.isEmpty) {
          _showToast('Role is missing for this user');
        } else {
          await _navigateToRolePage(userRole, doc.id);
        }
      } else {
        _showToast('Invalid Work ID or Password');
      }
    } catch (e) {
      _showToast('Error: $e');
    } finally {
      CustomNotifier.triggerLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: CustomNotifier.isLoading,
      builder: (context, isLoading, child) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    workIdController: _workIdController,
                    labelText: 'Employee Number',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    workIdController: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
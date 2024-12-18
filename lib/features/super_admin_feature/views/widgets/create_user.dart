import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/widgets/custom_text_fields.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _workIdController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  String _selectedRole = 'employee';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _roles = ['admin', 'employee'];

  void _createUser() async {
    final String name = _nameController.text.trim();
    final String password = _passwordController.text.trim();
    final String workId = _workIdController.text.trim();
    final String uid = _uidController.text.trim();

    if (name.isEmpty || password.isEmpty || workId.isEmpty || uid.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
      return;
    }

    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'password': password,
        'work_id': workId,
        'role': _selectedRole,
        'uid': uid,
      });

      Fluttertoast.showToast(msg: 'User created successfully');

      _nameController.clear();
      _passwordController.clear();
      _workIdController.clear();
      _uidController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error creating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CustomTextField(
                workIdController: _nameController, labelText: 'Name'),
            const SizedBox(height: 16),
            CustomTextField(
                workIdController: _passwordController,
                labelText: 'Password',
                obscureText: true),
            const SizedBox(height: 16),
            CustomTextField(
                workIdController: _workIdController, labelText: 'Work ID'),
            const SizedBox(height: 16),
            CustomTextField(
                workIdController: _uidController, labelText: 'user UID'),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: _roles.map<DropdownMenuItem<String>>((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createUser,
              child: const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
  
}

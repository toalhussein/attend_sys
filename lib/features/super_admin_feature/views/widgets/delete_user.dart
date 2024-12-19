import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteUserPage extends StatefulWidget {
  const DeleteUserPage({super.key});

  @override
  State<DeleteUserPage> createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  final TextEditingController _workIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _deleteUser() async {
    final String workId = _workIdController.text.trim();

    if (workId.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter a Work ID');
      return;
    }

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('work_id', isEqualTo: workId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Fluttertoast.showToast(msg: 'No user found with this Work ID');
        return;
      }

      for (var doc in querySnapshot.docs) {
        await _firestore.collection('users').doc(doc.id).delete();
      }

      Fluttertoast.showToast(msg: 'User deleted successfully');
      _workIdController.clear();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _workIdController,
              decoration: const InputDecoration(
                labelText: 'Work ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _deleteUser,
              child: const Text('Delete User'),
            ),
          ],
        ),
      ),
    );
  }
}

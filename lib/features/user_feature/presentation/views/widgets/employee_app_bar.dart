import 'package:attend_sys/features/login_feature/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmployeeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Employee Page'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            final pref = await SharedPreferences.getInstance();
            await pref.remove('id');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          icon: const Icon(Icons.login),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

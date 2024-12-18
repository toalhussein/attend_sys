import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login_feature/presentation/views/login_view.dart';

class CustomLogoutIcon extends StatelessWidget {
  const CustomLogoutIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.login),
      onPressed: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('id');
        pref.remove('role');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }
}
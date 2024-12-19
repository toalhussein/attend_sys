import 'package:attend_sys/features/super_admin_feature/views/widgets/custom_navigation_tile.dart';
import 'package:attend_sys/main.dart';
import 'package:flutter/material.dart';
import '../../features/login_feature/presentation/views/login_view.dart';

class CustomLogoutButton extends StatelessWidget {
  const CustomLogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomNavigationTile(
      title: 'Logout',
      icon: Icons.logout,
      onTap: () {
        LocalStorage.userData.remove('id');
        LocalStorage.userData.remove('role');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
    );
  }
}

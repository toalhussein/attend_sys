import 'package:attend_sys/core/widgets/custom_logout_icon.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/create_user.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/custom_navigation_tile.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/delete_user.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/feature_not_available_dialog.dart';
import 'package:attend_sys/features/super_admin_feature/views/widgets/user_details.dart';
import 'package:flutter/material.dart';

class SuperAdminDrawer extends StatelessWidget {
  const SuperAdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Super Admin',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const CustomNavigationTile(
            title: 'Create User',
            icon: Icons.add,
            page: CreateUserPage(),
          ),
          const CustomNavigationTile(
            title: 'Delete User',
            icon: Icons.delete,
            page: DeleteUserPage(),
          ),
          CustomNavigationTile(
            title: 'Analysis Sheet',
            icon: Icons.analytics,
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => const FeatureNotAvailableDialog(),
              );
            },
          ),
          CustomNavigationTile(
            title: 'User Details',
            icon: Icons.person,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDetailsPage(
                    name: 'name',
                    workId: 'work_id',
                    role: 'role',
                    residenceCity: 'residence_city',
                    workCity: 'work_city',
                  ),
                ),
              );
            },
          ),
          const CustomLogoutButton(),
        ],
      ),
    );
  }
}

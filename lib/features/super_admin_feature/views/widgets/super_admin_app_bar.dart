// ignore_for_file: library_private_types_in_public_api

import 'package:attend_sys/features/admin_feature/presentation/views/widgets/user_search_delegate.dart';
import 'package:flutter/material.dart';

class SuperAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SuperAdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Super Admin Page'),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: UserSearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

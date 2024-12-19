import 'package:attend_sys/features/admin_feature/presentation/views/admin_view.dart';
import 'package:attend_sys/features/login_feature/presentation/views%20model/login_cubit.dart';
import 'package:attend_sys/features/super_admin_feature/views/super_admin.dart';
import 'package:attend_sys/features/user_feature/presentation/views/user_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/login_feature/presentation/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final preferences = await SharedPreferences.getInstance();
  LocalStorage.initialize(preferences);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: getHomePage(),
      ),
    );
  }

  Widget getHomePage() {
    final userId = LocalStorage.userData.getString('id');
    final userRole = LocalStorage.userData.getString('role');

    if (userId == null) {
      return const LoginPage();
    }

    switch (userRole) {
      case 'employee':
        return const EmployeePage();
      case 'admin':
        return const AdminPage();
      case 'super_admin':
        return const SuperAdminPage();
      default:
        return const LoginPage();
    }
  }
}

class LocalStorage {
  static late SharedPreferences userData;

  LocalStorage._();

  static void initialize(SharedPreferences preferences) {
    userData = preferences;
  }
}

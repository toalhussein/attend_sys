import 'package:attend_sys/core/widgets/custom_app_bar.dart';
import 'package:attend_sys/features/login_feature/presentation/views%20model/login_cubit.dart';
import 'package:attend_sys/features/login_feature/presentation/views%20model/login_states.dart';
import 'package:attend_sys/features/login_feature/presentation/views/widgets/employee_number_field.dart';
import 'package:attend_sys/features/login_feature/presentation/views/widgets/login_button.dart';
import 'package:attend_sys/features/login_feature/presentation/views/widgets/passoword_field.dart';
import 'package:attend_sys/features/super_admin_feature/views/super_admin.dart';
import 'package:attend_sys/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: listener,
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: Form(
            key: loginKey,
            child: Scaffold(
              appBar: const CustomAppBar(
                title: 'Login',
              ),
              body: Center(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    EmployeeNumberField(
                      workIdController: _workIdController,
                    ),
                    PassowordField(
                      passwordController: _passwordController,
                    ),
                    LoginButton(
                      onPressed: _login,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void listener(BuildContext context, LoginStates state) {
    if (state is LoginFailed) {
      _showToast(state.errorMessage);
    } else if (state is LoginSuccess) {
      saveUser(state.userID, state.userRole);
      _navigateToRolePage(state.userRole);
      _showToast('Login successful');
    }
  }

  Future<void> _login() async {
    if (loginKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).login(
        workId: _workIdController.text,
        password: _passwordController.text,
      );
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  void _navigateToRolePage(String role) async {
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
  }

  void saveUser(String userId, String role) {
    LocalStorage.userData.setString('id', userId);
    LocalStorage.userData.setString('role', role);
  }
}

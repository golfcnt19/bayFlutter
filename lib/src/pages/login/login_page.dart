import 'package:bay_flutter1/src/bloc/login/login_bloc.dart';
import 'package:bay_flutter1/src/constants/asset.dart';
import 'package:bay_flutter1/src/models/user.dart';
import 'package:bay_flutter1/src/pages/app_routes.dart';
import 'package:bay_flutter1/src/widgets/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameEditController = TextEditingController();
  final _passwordEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameEditController.text = "admin";
    _passwordEditController.text = "1234";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        switch (state.status) {
          case LoginStatus.failed:
            CustomFlushbar.showError(context, message: state.dialogMessage);
            break;
          case LoginStatus.success:
            Navigator.pushReplacementNamed(context, AppRoute.home);
            break;
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner
            SizedBox(
              height: 200,
              child: Image.asset(Asset.logoImage),
            ),
            Card(
              margin: const EdgeInsets.only(left: 30, right: 30),
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Username
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      children: [
                        Icon(Icons.people),
                        SizedBox(width: 30),
                        Expanded(
                          child: TextField(
                            controller: _usernameEditController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Password
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      children: [
                        Icon(Icons.lock),
                        SizedBox(width: 30),
                        Expanded(
                          child: TextField(
                            controller: _passwordEditController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Login
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 16, right: 16),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.status == LoginStatus.fetching
                              ? null
                              : () => context.read<LoginBloc>().add(LoginEventLogin(User(
                                    _usernameEditController.text,
                                    _passwordEditController.text,
                                  ))),
                          child: Text("Login"),
                        );
                      },
                    ),
                  ),
                  // Register
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16, right: 16),
                    child: OutlinedButton(onPressed: _handleRegister, child: Text("Register")),
                  ),

                  // Footer
                  SizedBox(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _handleLogin() {
    final username = _usernameEditController.text;
    final password = _passwordEditController.text;
    print("Login: $username, $password");

    // Navigator.pushNamed(context, AppRoute.home);
    Navigator.pushReplacementNamed(context, AppRoute.home);
  }

  void _handleRegister() {
    _usernameEditController.text = "";
    _passwordEditController.text = "";
    print("Register");

    _showMyDialog();
  }

  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text("Login failed"),
        );
      },
    );
  }
}

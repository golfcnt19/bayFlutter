import 'package:bay_flutter1/src/app.dart';
import 'package:bay_flutter1/src/constants/network_api.dart';
import 'package:bay_flutter1/src/models/user.dart';
import 'package:bay_flutter1/src/pages/app_routes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(
          status: LoginStatus.init,
          dialogMessage: "",
        )) {
    // Login
    on<LoginEventLogin>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.fetching));
      final String username = event.payload.username;
      final String password = event.payload.password;

      await Future.delayed(Duration(seconds: 1));

      if (username == 'admin' && password == '1234') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(NetworkAPI.token, 'TExkgk0494oksrkf');
        await prefs.setString(NetworkAPI.username, username);

        // Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.home);
        // Emit
        emit(state.copyWith(status: LoginStatus.success));
        // hideKeyboard();
      } else {
        print("Login failed");
        emit(state.copyWith(dialogMessage: "Login failed", status: LoginStatus.failed));
        await Future.delayed(Duration(milliseconds: 100));
        emit(state.copyWith(dialogMessage: ""));
      }
    });

    // Logout
    on<LoginEventLogout>((LoginEventLogout event, Emitter emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushReplacementNamed(navigatorState.currentContext!, AppRoute.login);
      // Emit
      emit(state.copyWith(status: LoginStatus.init));
    });
  }
}

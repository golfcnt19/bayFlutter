part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object?> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final User payload;

  const LoginEventLogin(this.payload);
}

class LoginEventLogout extends LoginEvent {}

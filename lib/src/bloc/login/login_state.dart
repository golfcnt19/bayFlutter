part of 'login_bloc.dart';

enum LoginStatus { fetching, success, failed, init }

class LoginState extends Equatable {
  const LoginState({required this.status, required this.dialogMessage});

  final LoginStatus status;
  final String dialogMessage;

  LoginState copyWith({
    LoginStatus? status,
    String? dialogMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object> get props => [status, dialogMessage];
}

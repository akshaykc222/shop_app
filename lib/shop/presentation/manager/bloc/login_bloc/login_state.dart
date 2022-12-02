part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginDataFetchedState extends LoginState {
  final LoginResponse data;

  const LoginDataFetchedState(this.data);

  @override
  List<Object?> get props => [data];
}


class LoginErrorState extends LoginState {
  final String error;

  const LoginErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class PasswordEyeState extends LoginState {
  final bool shown;


 const PasswordEyeState(this.shown);

  @override
  List<Object?> get props => [shown];
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithPassword extends LoginEvent {
  final String email;
  final String password;
  final Function(String) onError;
  final Function onSuccess;
  const LoginWithPassword({
    required this.email,
    required this.password,
    required this.onError,
    required this.onSuccess,
  });

  @override
  List<Object?> get props => [email, password, onSuccess, onError];
}

class ShowPasswordEvent extends LoginEvent {
  const ShowPasswordEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountDetailEvent extends LoginEvent {
  final BuildContext context;

  const GetAccountDetailEvent(this.context);

  @override
  List<Object?> get props => [];
}

class ChangePasswordEvent extends LoginEvent {
  final BuildContext context;
  final String password;

  const ChangePasswordEvent(this.context, this.password);

  @override
  List<Object?> get props => [];
}

class ChangeAccountDetailsEvent extends LoginEvent {
  final ChangeAccountDetailsModel model;
  final BuildContext context;

  const ChangeAccountDetailsEvent(this.model, this.context);

  @override
  List<Object?> get props => [];
}

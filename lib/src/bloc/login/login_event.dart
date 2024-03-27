part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent(this.email, this.password);
}

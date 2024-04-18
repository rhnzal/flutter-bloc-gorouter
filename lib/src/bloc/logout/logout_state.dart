part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();
  
  @override
  List<Object> get props => [];
}

final class LogoutInitialState extends LogoutState {}

final class LogoutLoadingState extends LogoutState {}

final class LogoutSuccessState extends LogoutState {}

final class LogoutNoInternetState extends LogoutState {}

final class LogoutErrorState extends LogoutState {}

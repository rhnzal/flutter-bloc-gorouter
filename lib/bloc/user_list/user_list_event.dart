part of 'user_list_bloc.dart';

sealed class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class UserListLoadEvent extends UserListEvent {}

class UserListReloadEvent extends UserListEvent {}

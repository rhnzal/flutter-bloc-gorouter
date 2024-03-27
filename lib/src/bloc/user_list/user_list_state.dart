part of 'user_list_bloc.dart';

// Package equatable digunakan untuk membandingkan object yang sama, jika tidak menggunakan package ini maka jika kita emit state berupa
// object dengan property yang sama persis, widget akan tetap direbuild. karena walaupun object sama tetapi hashcode mereka berbeda.
// dengan kata lain package ini digunakan untuk menghindari rebuild widget ketika state berupa custom class
sealed class UserListState extends Equatable {
  UserListState(this.userList);

  List<User> userList = [];

  @override
  List<Object> get props => [userList];
}

final class UserListInitialState extends UserListState {
  UserListInitialState(super.userList);
}

final class UserListLoadingState extends UserListState {
  UserListLoadingState(super.userList);
}

final class UserListSuccessState extends UserListState {
  UserListSuccessState(super.userList);
}

final class UserListErrorState extends UserListState {
  UserListErrorState(super.userList);
}

final class UserListNoInternetState extends UserListState {
  UserListNoInternetState(super.userList);
}

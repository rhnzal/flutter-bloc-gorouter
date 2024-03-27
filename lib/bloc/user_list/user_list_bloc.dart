import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/data/models/response.dart';
import 'package:flutter_bloc_architecture/data/services/user_services.dart';

import '../../data/models/user.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitialState([])) {

    on<UserListLoadEvent>((event, emit) async {
      emit(UserListLoadingState(state.userList));
      var response = await UserService.getUserListData();

      if (response.isSuccess) {
        List<User> userList = List.from(state.userList);

        for(var user in response.data) {
          print(user);
          userList.add(User.fromJson(user));
        }

        emit(UserListSuccessState(userList));
      
      } else if (response.status == HTTPResponseStatus.noInternet) {
        emit(UserListNoInternetState(state.userList));

      } else {
        emit(UserListErrorState(state.userList));

      }

    });


    // dengan adanya bloc kita dapat menjalakan fungsi ini dari mana saja, misalkan ketika ingin memindahkan widget refreshIndicator ke file lain
    // fungsi ini tetap bisa digunakan selama mendapatkan instance bloc yg sama 
    on<UserListReloadEvent>((event, emit) async {
      emit(UserListLoadingState([]));

      // Panggil Event UserListLoadEvent langsung di dalam event lain
      add(UserListLoadEvent());
    });
  }
}

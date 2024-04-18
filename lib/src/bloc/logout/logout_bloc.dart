import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/src/data/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitialState()) {
    on<LogoutPressedEvent>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      // if success
      pref.remove('isLogedIn');
      LocalStorage.pref.remove('isLogedIn');
      emit(LogoutSuccessState());
    });
  }
}

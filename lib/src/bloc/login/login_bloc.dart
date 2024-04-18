import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/src/data/models/response.dart';
import 'package:flutter_bloc_architecture/src/data/services/auth_services.dart';
import 'package:flutter_bloc_architecture/src/data/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {

    on<LoginButtonPressedEvent>((event, emit) async {
      emit(LoginLoadingState());
      var response = await AuthServices.login(email: event.email, password: event.password);

      if (response.isSuccess) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        
        pref.setBool('isLogedIn', true);
        LocalStorage.pref.setBool('isLogedIn', true);
        
        emit(LoginSuccesState());
      
      } else if (response.status == HTTPResponseStatus.noInternet) {
        emit(LoginNoInternetState());

      } else {
        emit(LoginErrorState());

      }
    
    });
  }
}

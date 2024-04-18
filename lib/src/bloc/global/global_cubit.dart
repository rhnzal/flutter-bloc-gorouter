import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/src/data/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// untuk global state ini menggunakan cubit karena tidak terlalu kompleks
class GlobalCubit extends Cubit<bool> {
  GlobalCubit() : super(false);

  void checkIsLogedIn() {
    // SharedPreferences pref = await SharedPreferences.getInstance();

    // emit(pref.getBool('isLogedIn') ?? false);
    emit(LocalStorage.pref.getBool('isLogedIn') ?? false);
    

  }
}

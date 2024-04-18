import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/observer.dart';
import 'package:flutter_bloc_architecture/src/data/utils/local_storage.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await LocalStorage.init();
  // digunakan untuk memantau perubahan/error utk seluruh bloc
  Bloc.observer = GlobalObserver();
  runApp(App());
}
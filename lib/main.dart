import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/observer.dart';

import 'app.dart';

void main() {

  // digunakan untuk memantau perubahan/error utk seluruh bloc
  Bloc.observer = GlobalObserver();
  runApp(App());
}
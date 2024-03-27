import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/login/login_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/resource/resource_list_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/404/not_found_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/login/login_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/multi_list/multi_list_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/user_list/user_list_page.dart';

import './src/ui/pages/export_pages.dart';

class AppRoute {
  //bloc instance
  UserListBloc userListBloc = UserListBloc();
  LoginBloc loginBloc = LoginBloc();
  ResourceListBloc resourceListBloc = ResourceListBloc();

  // Fungsi ini dieksekusi setiap pindah halaman menggunakan named route sekaligus melakukan injeksi instance bloc ke dalam context.

  // BlocProvider.value digunakan untuk men-assign bloc instance yang sudah di declare sebelumnya,
  // Jika halaman memerlukan lebih dari satu state / bloc instance maka gunakan MultiBlocProvider lalu di property providers masukan BlocProvider.value nya
  Route onRoute(RouteSettings settings) {
    print('pindah halaman');
    switch(settings.name) {
      case AppPage.homePage:
        return CupertinoPageRoute(
          builder: (context) => const HomePage(),
        );

      case AppPage.userListPage:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider.value(
            value: userListBloc,
            child: const UserListPage(),
          ),
        );
      
      case AppPage.loginPage:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider.value(
            value: loginBloc,
            child: const LoginPage(),
          ),
        );

      case AppPage.multiListPage:
        return CupertinoPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: userListBloc),
              BlocProvider.value(value: resourceListBloc),
            ], 
            child: const MultiListPage()
          ),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }

  }

}

class AppPage {
  static const String homePage = '/';
  static const String userListPage = '/user-list';
  static const String loginPage = '/login';
  static const String multiListPage ='/multi-list';

  static const String notFoundPage ='/not-found';
}
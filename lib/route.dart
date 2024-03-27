import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_bloc_architecture/ui/pages/404/not_found_page.dart';
import 'package:flutter_bloc_architecture/ui/pages/user_list/user_list_page.dart';

import './ui/pages/export_pages.dart';

class AppRoute {
  //bloc instance
  UserListBloc userListBloc = UserListBloc();

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
  static const String addUserPage = '/add-user';

  static const String notFoundPage ='/not-found';
}
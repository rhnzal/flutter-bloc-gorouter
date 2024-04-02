import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'src/bloc/login/login_bloc.dart';
import 'src/bloc/resource/resource_list_bloc.dart';
import 'src/bloc/user_list/user_list_bloc.dart';
import 'src/ui/pages/export_pages.dart';

class AppRoute {
  //bloc instance
  static UserListBloc userListBloc = UserListBloc();
  static LoginBloc loginBloc = LoginBloc();
  static ResourceListBloc resourceListBloc = ResourceListBloc();
  

  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppPage.homePage,
        pageBuilder: (context, state) {
          return const CupertinoPage(
            child: HomePage()
          );
        },
        routes: [
          GoRoute(
            path: 'multi-list',
            name: AppPage.multiListPage,
            pageBuilder: (context, state) {
              return CupertinoPage(
                child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: userListBloc),
                  BlocProvider.value(value: resourceListBloc),
                ], 
                child: const MultiListPage()
              )
              );
            },
          ),
          GoRoute(
            path: 'user-list',
            name: AppPage.userListPage,
            pageBuilder: (context, state) {
              return CupertinoPage(
                child: BlocProvider.value(
                  value: userListBloc,
                  child: const UserListPage(),
                )
              );
            },
          ),
          GoRoute(
            path: 'login',
            name: AppPage.loginPage,
            pageBuilder: (context, state) {
              return CupertinoPage(
                child: BlocProvider.value(
                  value: loginBloc,
                  child: const LoginPage(),
                )
              );
            },
          ),
        ]
      )
    ],
    errorPageBuilder: (context, state) {
      return const CupertinoPage(
        child: NotFoundPage()
      );
    },
    debugLogDiagnostics: true,
  );
}


class AppPage {
  static const String homePage = 'home';
  static const String userListPage = 'user-list';
  static const String loginPage = 'login';
  static const String multiListPage ='multi-list';

  static const String notFoundPage ='not-found';
}
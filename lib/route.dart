import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/cart/cart_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/shopping/shopping_page.dart';
import 'package:flutter_bloc_architecture/src/ui/product/product_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/bloc/cart/cart_cubit.dart';
import 'src/bloc/login/login_bloc.dart';
import 'src/bloc/logout/logout_bloc.dart';
import 'src/bloc/resource/resource_list_bloc.dart';
import 'src/bloc/user_list/user_list_bloc.dart';
import 'src/data/utils/local_storage.dart';
import 'src/ui/pages/export_pages.dart';

/// untuk rute app kita sesuaikan saja, pakai go router untuk semua route tetapi jika tidak memungkinkan bisa digabung dengan navigator seperti contoh halaman simmiliar produk di app ini

class AppRoute {
  //bloc instance
  static UserListBloc userListBloc = UserListBloc();
  static LoginBloc loginBloc = LoginBloc();
  static ResourceListBloc resourceListBloc = ResourceListBloc();
  static LogoutBloc logoutBloc = LogoutBloc();
  static CartCubit cartCubit = CartCubit();

  static final bool _isLogedIn =
      LocalStorage.pref.getBool('isLogedIn') ?? false;

  GoRouter router = GoRouter(
    initialLocation: _isLogedIn ? '/' : '/login',
    routes: [
      GoRoute(
          path: '/',
          name: AppPage.homePage,
          pageBuilder: (context, state) {
            return CupertinoPage(
                child: BlocProvider.value(
              value: logoutBloc,
              child: const HomePage(),
            ));
          },
          routes: [
            GoRoute(
              path: 'multi-list',
              name: AppPage.multiListPage,
              onExit: (context) async {
                // this onExit function works like willpopscope
                bool? result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('You want to exit ?'),
                    content: const Text('any changes will not be saved'),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  ),
                );

                if (result != null) return result;
                return false;
              },
              pageBuilder: (context, state) {
                return CupertinoPage(
                    child: MultiBlocProvider(providers: [
                  BlocProvider.value(value: userListBloc),
                  BlocProvider.value(value: resourceListBloc),
                ], child: const MultiListPage()));
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
                ));
              },
            ),
            GoRoute(
                path: 'shopping',
                name: AppPage.shoppingPage,
                pageBuilder: (context, state) {
                  return const CupertinoPage(child: ShoppingPage());
                },
                routes: [
                  GoRoute(
                      path: 'cart',
                      name: AppPage.cartPage,
                      pageBuilder: (context, state) {
                        return CupertinoPage(
                          child: BlocProvider.value(
                            value: cartCubit,
                            child: const CartPage(),
                          )
                        );
                      }),
                  GoRoute(
                    path: 'product/:pid',
                    name: AppPage.productPage,
                    pageBuilder: (context, state) {
                      String productId = state.pathParameters['pid'] ?? '';

                      return CupertinoPage(
                          child: BlocProvider.value(
                            value: cartCubit,
                            child: ProductPage(productId: productId),
                          )
                      );
                    },

                    // ke cart page dari sini pake navigator push aja
                    // routes: [
                    //   GoRoute(
                    //     path: 'cart',
                    //     pageBuilder: (context, state) {
                    //       return const CupertinoPage(
                    //         child: CartPage()
                    //       );
                    //     }
                    //   ),
                    // ]
                  ),
                ])
          ]),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CupertinoPage(
              child: BlocProvider.value(
            value: loginBloc,
            child: const LoginPage(),
          ));
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const CupertinoPage(child: NotFoundPage());
    },
    debugLogDiagnostics: true,
  );
}

class AppPage {
  static const String homePage = 'home';
  static const String userListPage = 'user-list';
  static const String loginPage = 'login';
  static const String multiListPage = 'multi-list';
  static const String shoppingPage = 'shopping';
  static const String cartPage = 'cart';
  static const String productPage = 'product';

  static const String notFoundPage = 'not-found';
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/cart/cart_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/scaffold_bottom_nav.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/pages/home/bottom_nav_home_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/pages/home_detail/bottom_nav_home_detail_page.dart';
import 'package:flutter_bloc_architecture/src/ui/pages/home_bottom_nav/pages/notification/notification_page.dart';
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
import 'src/ui/pages/home_bottom_nav/pages/notification_detail/bottom_nav_notification_detail_page.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

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
    navigatorKey: _rootNavigatorKey,
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
                }
              ),
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
            ]
          )
        ]
      ),


      // Jika ingin menggunakan bottom navbar bisa menggunakan shellroute, dan jangan lupa kasih navigator key
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return CupertinoPage(child: ScaffolBottomNav(child: child));
        },
        routes: [
          GoRoute(
            path: '/bottom-nav-home',
            name: AppPage.bottomNavHomePage,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: BottomNavHomePage()
              );
            },
            routes: [
              GoRoute(
                path: 'bottom-nav-home-detail',
                name: AppPage.bottomNavHomeDetailPage,
                // jika dikasih keterangan navigator key lain maka halaman akan muncul di depan/atas bottom navbar
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return CupertinoPage(child: BottomNavHomeDetailPage());
                },
              )
            ]
          ),
          GoRoute(
            path: '/bottom-nav-notif',
            name: AppPage.bottomNavNotificationPage,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: BottomNavNotificationPage()
              );
            },
            routes: [
              GoRoute(
                path: 'bottom-nav-notif-detail',
                name: AppPage.bottomNavNotificationDetailPage,
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: BottomNavNotificationDetailPage());
                },
              )
            ]
          ),
        ]
      ),


      // GoRoute(
      //   path: '/home-bottom-nav',
      //   name: AppPage.homeBottomNavPage,
      //   pageBuilder: (context, state) {
      //     return CupertinoPage(
      //       child: HomeBottomNavPage()
      //     );
      //   }, 
      // ),
      
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
  // static const String homeBottomNavPage = 'home-bottom-nav';
  static const String bottomNavHomePage = 'bottom-nav-home';
  static const String bottomNavNotificationPage = 'bottom-nav-notif';
  static const String bottomNavHomeDetailPage = 'bottom-nav-home-detail';
  static const String bottomNavNotificationDetailPage = 'bottom-nav-notif-detail';

  static const String notFoundPage = 'not-found';
}

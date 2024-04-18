// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:flutter_bloc_architecture/src/bloc/logout/logout_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('initstate home page');
  }

  @override
  Widget build(BuildContext context) {
    var logoutBloc = context.read<LogoutBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          BlocListener<LogoutBloc, LogoutState>(
            bloc: logoutBloc,
            listener: (context, state) async {
              if (state is LogoutSuccessState) {
                showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (context) => const AlertDialog(
                    title: Text('Logout Success'),
                    content: Text('Tunggu Sebentar, anda akan diarahkan ke halaman home'),
                    actions: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   }, 
                      //   child: const Text('Ok')
                      // )
                    ],
                  ),
                );
                await Future.delayed(const Duration(seconds: 2));
                if (context.mounted) {
                  context.pop();
                  GoRouter.of(context).go('/login');
                }
              }

              if (state is LogoutErrorState) {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text('Login Gagal'),
                    content: const Text('Terjadi kesalahan saat melakukan logout, silakan coba lagi dalam beberapa saat'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: const Text('Ok')
                      )
                    ],
                  ),
                );
              }

              if (state is LogoutNoInternetState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Anda tidak terhubung ke Internet'))
                );
              }

            },
            child: IconButton(
                onPressed: () {
                  logoutBloc.add(LogoutPressedEvent());
                },
                icon: Icon(Icons.logout)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/multi-list');
              },
              child: Text('Multi List')
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/user-list');
              },
              child: Text('User List')
            ),

            const Divider(),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/shopping');
              },
              child: Text('Shopping')
            ),

          ],
        ),
      ),

      
    );
  }
}

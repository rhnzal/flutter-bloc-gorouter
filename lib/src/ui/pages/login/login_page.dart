import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/route.dart';
import 'package:flutter_bloc_architecture/src/bloc/login/login_bloc.dart';
import 'package:go_router/go_router.dart';

// Contoh usecase ketika memerlukan stateful widget, bisa di gabungkan dengan bloc

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool textObsecure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginBloc loginBloc;

  @override
  void dispose() {
    super.dispose();
    
    // dispose controller yang sudah tidak akan dipakai untuk mencegah memory leak 
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();

    // jika ada suatu case harus menggunakan setstate, agar instance loginBloc tidak dibuat ulang maka pindahkan ke initstate
    loginBloc = context.read<LoginBloc>();
    log('initstate login page');
  }

  @override
  Widget build(BuildContext context) {
    // var loginBloc = context.read<LoginBloc>(); -> dipindahkan ke initstate supaya tidak di re-run ketika menjalankan setstate

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) async {
          if (state is LoginSuccesState) {
            showDialog(
              barrierDismissible: false,
              context: context, 
              builder: (context) => const AlertDialog(
                title: Text('Login Success'),
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
              GoRouter.of(context).go('/');
            }
            
            
          }

          if (state is LoginErrorState) {
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: const Text('Login Gagal'),
                content: const Text('Terjadi kesalahan saat melakukan login, silakan coba lagi dalam beberapa saat'),
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

          if (state is LoginNoInternetState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Anda tidak terhubung ke Internet'))
            );
          }
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  helperText: 'hint: eve.holt@reqres.in',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurpleAccent
                    )
                  )
                ),
              ),
          
              const SizedBox(height: 20),
          
              TextFormField(
                obscureText: textObsecure,
                controller: passwordController,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  helperText: 'hint: cityslicka',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        textObsecure = !textObsecure;
                      });
                    }, 
                    icon: Icon(textObsecure ? Icons.visibility : Icons.visibility_off)
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurpleAccent
                    )
                  )
                ),
              ),
          
              const SizedBox(height: 64),
          
              BlocBuilder<LoginBloc, LoginState>(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const CircularProgressIndicator(color: Colors.deepPurpleAccent,);
                  }

                  return ElevatedButton(
                    onPressed: () {
                      loginBloc.add(LoginButtonPressedEvent(emailController.text, passwordController.text));
                    }, 
                    child: const Text('Login')
                  );
                },
              )
            ],
          ),
        ),
      ),      
    );
  }
}
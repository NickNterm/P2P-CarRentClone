import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/auth/auth_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/add_car_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (sl<AuthBloc>().state is AuthInitial) {
      sl<AuthBloc>().add(FingerPrintUnlockEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading ||
              state is AuthInitial ||
              state is AuthError) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Psudo Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputWidget(
                    hintText: 'Username',
                    icon: Icons.account_circle,
                    keyboardType: TextInputType.emailAddress,
                    makeController: usernameController,
                  ),
                  const SizedBox(height: 16),
                  InputWidget(
                    hintText: 'Password',
                    icon: Icons.lock,
                    password: true,
                    keyboardType: TextInputType.visiblePassword,
                    makeController: passwordController,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      sl<AuthBloc>().add(
                        LoginEvent(
                          username: usernameController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AuthSuccess) {
            return Center(
              child: Text(state.user.name),
            );
          }
          print(state);
          return const SizedBox();
        },
      ),
    );
  }
}

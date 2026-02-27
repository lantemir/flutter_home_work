import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';
import 'widgets/email_field.dart';
import 'widgets/password_field.dart';
import 'widgets/login_button.dart';
import 'widgets/login_status_listener.dart';

class LoginFormPage extends StatelessWidget {
  const LoginFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginFormView(),
    );
  }
}

class _LoginFormView extends StatelessWidget {
  const _LoginFormView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc: Login Form')),
      body: const LoginStatusListener(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              EmailField(),
              SizedBox(height: 12),
              PasswordField(),
              SizedBox(height: 16),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

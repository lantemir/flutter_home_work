import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_bloc.dart';
import '../login_event.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordValid = context.select(
      (LoginBloc b) => b.state.passwordValid,
    );

    return TextField(
      obscureText: true,
      onChanged: (v) => context.read<LoginBloc>().add(PasswordChanged(v)),
      decoration: InputDecoration(
        labelText: 'Пароль',
        helperText: 'Минимум 6 символов',
        errorText: passwordValid ? null : 'Слишком короткий пароль',
        border: const OutlineInputBorder(),
      ),
    );
  }
}

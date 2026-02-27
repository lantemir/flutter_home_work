import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_bloc.dart';
import '../login_event.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final emailValid = context.select((LoginBloc b) => b.state.emailValid);

    return TextField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (v) => context.read<LoginBloc>().add(EmailChanged(v)),
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: emailValid ? null : 'Некорректный email',
        border: const OutlineInputBorder(),
      ),
    );
  }
}

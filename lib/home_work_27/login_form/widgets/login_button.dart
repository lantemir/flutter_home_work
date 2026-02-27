import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_bloc.dart';
import '../login_event.dart';
import '../login_state.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final canSubmit = context.select((LoginBloc b) => b.state.canSubmit);
    final status = context.select((LoginBloc b) => b.state.status);
    final loading = status == LoginStatus.loading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (!canSubmit || loading)
            ? null
            : () => context.read<LoginBloc>().add(const LoginSubmitted()),
        child: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Войти'),
      ),
    );
  }
}

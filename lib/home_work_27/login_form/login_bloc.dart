import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void _onEmailChanged(EmailChanged e, Emitter<LoginState> emit) {
    final email = e.email.trim();
    final emailValid = _emailRegex.hasMatch(email);
    emit(
      state.copyWith(
        email: e.email,
        emailValid: emailValid || email.isEmpty,
        status: LoginStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged e, Emitter<LoginState> emit) {
    final pass = e.password;
    final passwordValid = pass.length >= 6;
    emit(
      state.copyWith(
        password: pass,
        passwordValid: passwordValid || pass.isEmpty,
        status: LoginStatus.initial,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(LoginSubmitted e, Emitter<LoginState> emit) async {
    final email = state.email.trim();
    final password = state.password;

    final emailValid = _emailRegex.hasMatch(email);
    final passwordValid = password.length >= 6;

    if (!emailValid || !passwordValid) {
      emit(
        state.copyWith(
          emailValid: emailValid,
          passwordValid: passwordValid,
          status: LoginStatus.error,
          errorMessage: 'Проверьте email и пароль (пароль минимум 6 символов).',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      // демо-логика
      if (email == 'test@mail.com' && password == '123456') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage: 'Неверные учетные данные.',
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Ошибка сети. Повторите попытку.',
        ),
      );
    }
  }
}

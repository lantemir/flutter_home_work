import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthError(Object e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'invalid-email':
        return 'Неверный формат email.';
      case 'user-not-found':
        return 'Пользователь не найден.';
      case 'wrong-password':
        return 'Неверный пароль.';
      case 'email-already-in-use':
        return 'Email уже зарегистрирован.';
      case 'weak-password':
        return 'Слишком слабый пароль (минимум 6 символов).';
      case 'too-many-requests':
        return 'Слишком много попыток. Попробуйте позже.';
      case 'network-request-failed':
        return 'Проблема с интернетом.';
      default:
        return 'Ошибка авторизации: ${e.code}';
    }
  }
  return 'Неизвестная ошибка: $e';
}

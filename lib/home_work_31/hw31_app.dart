import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'router.dart';
import 'services/token_storage.dart';

/// Это мини-приложение HW31.

class HomeWork31App extends StatefulWidget {
  const HomeWork31App({super.key});

  @override
  State<HomeWork31App> createState() => _HomeWork31AppState();
}

class _HomeWork31AppState extends State<HomeWork31App> {
  late final _router = buildRouter();

  /// locale переключаем ru/en
  final ValueNotifier<Locale> _locale = ValueNotifier(const Locale('en'));

  /// secure storage (токен)
  late final TokenStorage tokenStorage = TokenStorage(
    const FlutterSecureStorage(),
  );

  @override
  void dispose() {
    _locale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: _locale,
      builder: (_, locale, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,

          /// Важно: задаём locale и список поддерживаемых
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ru')],

          /// Передача "глобальных" вещей вниз проще делать через Inherited/Provider.
          /// Для учебного примера — через static/global тоже можно, но мы сделаем
          /// простую передачу через callbacks: в SettingsScreen будем менять _locale.
          builder: (context, child) {
            // Прокидываем доступ к tokenStorage/locale changer через Inherited не делаем,
            // поэтому ниже в SettingsScreen возьмем их через (context.findAncestorStateOfType)
            // либо проще — сделаем static accessors. Чтобы не усложнять, пойдём другим путём:
            return Hw31Scope(
              locale: _locale,
              tokenStorage: tokenStorage,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}

/// Мини-самодельный scope, чтобы экраны могли достать locale/tokenStorage
class Hw31Scope extends InheritedWidget {
  const Hw31Scope({
    required this.locale,
    required this.tokenStorage,
    required super.child,
  });

  final ValueNotifier<Locale> locale;
  final TokenStorage tokenStorage;

  static Hw31Scope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<Hw31Scope>();
    assert(scope != null, 'HW31 scope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(Hw31Scope oldWidget) =>
      oldWidget.locale != locale || oldWidget.tokenStorage != tokenStorage;
}

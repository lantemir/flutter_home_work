import 'package:flutter/material.dart';

class Hw26NotesPage extends StatelessWidget {
  const Hw26NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const text = '''
HW26 — Анимации (конспект)

1) Staggered-анимации (Interval)
Что это: одна AnimationController, но разные части UI анимируются по очереди через Interval (0.0..0.4, 0.3..0.7, 0.6..1.0).
Когда применять: онбординг, карточки/детали, последовательное появление элементов.
Ошибки: 
- Делать несколько контроллеров без нужды (сложно управлять).
- Неправильные интервалы (перекрытия/все стартуют одновременно).

2) Hero-анимации между экранами
Что это: общий Tag на обоих экранах -> Flutter делает "перелёт" виджета.
Когда применять: список -> детали (картинка, аватар), галерея, карточки товаров.
Ошибки:
- Несовпадающие tags / разные размеры без ClipRect (дерганье).
- Сложные виджеты внутри Hero (лучше простая картинка/контейнер).

3) Анимации списков: AnimatedList
Что это: список с управлением вставкой/удалением через AnimatedListState (insertItem/removeItem).
Когда применять: динамические списки (добавление/удаление элементов), чат.
Ошибки:
- Менять data list без синхронизации с AnimatedListState.
- Неверный index при removeItem.

4) Пакеты Lottie / Rive
Что это: готовые векторные/JSON анимации (loading, success, empty state).
Когда применять: быстрый UI-фидбек, лоадеры, пустые состояния.
Ошибки:
- Не хранить ассеты / забыть добавить в pubspec.yaml
- Перегружать экран тяжёлыми анимациями (производительность).

5) AnimatedSwitcher
Что это: простой способ анимировать смену контента (child меняется по key) + кастомный transitionBuilder.
Ошибки:
- Без Key switcher не понимает что child поменялся.
- Слишком частые переключения без debounce.

6) Custom transition (PageRouteBuilder)
Что это: кастомная анимация навигации (fade + slide).
Ошибки:
- Использовать одинаковые durations без curve -> "плоско".
- Не учитывать обратный переход (reverse).
''';

    return Scaffold(
      appBar: AppBar(title: const Text('HW26 Notes')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(text)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  String displayed = "";

  @override
  void dispose() {
    _controller.dispose(); // важно освобождать контроллер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color.fromARGB(255, 47, 5, 120);

    return Scaffold(
      appBar: AppBar(
        title: Text("Temirlan1", style: TextStyle(color: Colors.white)),
        backgroundColor: purple,
        centerTitle: true,
      ),
      backgroundColor: purple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //1 input
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Введите текст",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2) кнопка — берём текст из input и показываем ниже
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => setState(() => displayed = _controller.text),
                child: const Text(
                  "Показать текст",
                  style: TextStyle(color: purple, fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              // 3) отображение введённого текста
              Text(
                displayed.isEmpty ? "Здесь появится ваш текст" : displayed,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // 4) изображение из интернета
              Image.network(
                "https://miro.medium.com/v2/resize:fit:1200/0*Y37daFMFwerE_zUr.jpg",
                height: 100,
                width: 200,
              ),

              const SizedBox(height: 30),

              // КНОПКА ПЕРЕХОДА НА ВТОРОЙ ЭКРАН
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                ),
                onPressed: () {
                  final textToSend = displayed.isEmpty ? "(пусто)" : displayed;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SecondPage(message: textToSend),
                    ),
                  );
                },
                child: const Text("Перейти на второй экран"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ВТОРОЙ ЭКРАН

class SecondPage extends StatelessWidget {
  final String message;
  const SecondPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const purple = Color.fromARGB(255, 47, 5, 120);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page", style: TextStyle(color: Colors.white)),
        backgroundColor: purple,
        centerTitle: true,
      ),
      backgroundColor: purple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Текст с первого экрана:",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 26),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Назад",
                  style: TextStyle(color: purple, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Домашнее задание — День 1 (Flutter и Dart)
// Тема: Основы Flutter и Dart. Работа с проектом, структурой и основными виджетами.Задания
// 1. Создайте новый проект Flutter.
// 2. Измените текст в приложении на «Привет, Flutter!».
// 3. Добавьте AppBar с вашим именем.
// 4. Измените цвет фона экрана.
// 5. Добавьте кнопку с обработчиком нажатия (onPressed).
// 6. Создайте StatefulWidget и реализуйте изменение текста по нажатию.
// 7. Добавьте отступы с помощью Padding или SizedBox.
// 8. Вставьте изображение с помощью Image.network.
// 9. Добавьте второй экран и переход между ними.
// 10. Проверьте, чтобы приложение запускалось без ошибок.Инструкция по оформлению и сдаче
// — Выполните все задания в одном проекте Flutter.
// — Название проекта: Имя_Фамилия_День1 (например, Ivan_Ivanov_Day1_Flutter).
// — Проверьте корректность запуска на эмуляторе или устройстве.
// — И оправить zip в LMS
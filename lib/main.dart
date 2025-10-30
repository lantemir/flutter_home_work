import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Temirlan", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 47, 5, 120),
        ),
        backgroundColor: Color.fromARGB(255, 47, 5, 120),
        body: Center(
          child: Text(
            "Привет, Flutter!",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    ),
  );
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
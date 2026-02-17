import 'package:flutter/material.dart';
import 'package:flutter_home_work/home_work_25/h_w_25.dart';
import 'package:provider/provider.dart';
import 'tasks_provider.dart';
import 'tasks_page.dart';

void main() {
  runApp(const MyRootApp());
}

class MyRootApp extends StatefulWidget {
  const MyRootApp({super.key});

  @override
  State<MyRootApp> createState() => _MyRootAppState();
}

class _MyRootAppState extends State<MyRootApp> {
  bool isDark = false;

  final ThemeData lightTheme = ThemeData.light();
  final ThemeData darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeWork25());
  }
}



// ChangeNotifierProvider(
//       create: (_) => TasksProvider(),
//       child: MaterialApp(
//         theme: lightTheme,
//         darkTheme: darkTheme,
//         themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
//         home: TasksPage(
//           isDark: isDark,
//           onToggleTheme: () {
//             setState(() {
//               isDark = !isDark;
//             });
//           },
//         ),
//       ),
//     );
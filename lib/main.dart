// HOME WORK 27______________________

import 'package:flutter/material.dart';
import 'home_work_27/hw27_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homework App',
      theme: ThemeData(useMaterial3: true),
      home: const HomeWork27MenuPage(), // <-- стартовая на проверку
    );
  }
}




// HOME WORK 28______________________

// import 'package:flutter/material.dart';
// import 'home_work_28/h_w_28.dart';

// void main() {
//   runApp(
//     const MaterialApp(debugShowCheckedModeBanner: false, home: HomeWork28()),
//   );
// }



// HOME WORK 32______________________

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';
// import 'home_work_32/hw32_app.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const HomeWork32App());
// }





// HOME WORK 29______________________

// import 'package:flutter/material.dart';
// import 'home_work_29/h_w_29.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeWork29(),
//     );
//   }
// }



// HOME WORK 31______________________

// import 'package:flutter/material.dart';
// import 'home_work_31/hw31_app.dart';

// void main() {
//   runApp(const HomeWork31App());
// }





// HOME WORK 30______________________

// import 'package:flutter/material.dart';
// import 'home_work_30/di/locator.dart';
// import 'home_work_30/h_w_30.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // обязательно перед async init
//   await setupLocator(); // async init + DI
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeWork30Screen.fromDI(), // фабрика вытаскивает usecase из get_it
//     );
//   }
// }


// HOME WORK 25_____________________

// import 'package:flutter/material.dart';
// import 'package:flutter_home_work/home_work_25/h_w_25.dart';
// import 'package:provider/provider.dart';
// import 'tasks_provider.dart';
// import 'tasks_page.dart';

// void main() {
//   runApp(const MyRootApp());
// }

// class MyRootApp extends StatefulWidget {
//   const MyRootApp({super.key});

//   @override
//   State<MyRootApp> createState() => _MyRootAppState();
// }

// class _MyRootAppState extends State<MyRootApp> {
//   bool isDark = false;

//   final ThemeData lightTheme = ThemeData.light();
//   final ThemeData darkTheme = ThemeData.dark();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: HomeWork25());
//   }
// }



import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:task_9/theme_contorller.dart';

import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("Taskaty");
  await Hive.openBox("DoneTasks");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = ThemeController();
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          themeMode: themeController.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: Home(themeController: themeController),
        );
      },
    );
  }
}
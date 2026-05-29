import 'package:flutter/material.dart';
import 'package:habit_tracker/core/themes/theme_provider.dart';

import 'package:habit_tracker/data/habit_database.dart';

import 'package:habit_tracker/domain/providers/habit_provider.dart';
import 'package:habit_tracker/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await HabitDatabase.instance.db;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => HabitProvider()..loadHabits(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer provides a fresh context below the provider tree
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProvider.themeData, // Listens to changes perfectly here
          home: const HomePage(),
        );
      },
    );
  }
}
// git pull origin dev3/habit_provider
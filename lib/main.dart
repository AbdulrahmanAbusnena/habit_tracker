import 'package:flutter/material.dart';
import 'package:habit_tracker/core/themes/dark_mode.dart';
import 'package:habit_tracker/core/themes/theme_provider.dart';
import 'package:habit_tracker/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkmode,
      home: HomePage(),
    );
  }
}

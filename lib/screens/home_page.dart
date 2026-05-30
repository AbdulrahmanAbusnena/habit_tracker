import 'package:flutter/material.dart';
import 'package:habit_tracker/shared/widgets/drawer.dart';
import 'package:habit_tracker/shared/widgets/floatingbutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: HomeDrawer(),
      floatingActionButton: FloatingButton(),
    );
  }
}

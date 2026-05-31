import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/providers/habit_provider.dart';
import 'package:habit_tracker/shared/widgets/drawer.dart';
import 'package:habit_tracker/shared/widgets/floatingbutton.dart';
import 'package:provider/provider.dart';
import '../domain/models/habit.dart';
import '../domain/providers/habit_provider.dart';
import '../shared/widgets/habit_tile.dart';
import '../shared/widgets/edit_habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();
    final habits = provider.habits;

    final pending = habits.where((h) => !h.isCompletedToday).toList();
    final completed = habits.where((h) => h.isCompletedToday).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Habits',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: HomeDrawer(),
      floatingActionButton: FloatingButton(),
      // body:
    );
  }
}

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

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          :
            // This is the empty states (when there are no habits at all )
            habits.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_task,
                    size: 56,
                    color: Theme.of(
                      context,
                    ).colorScheme.inversePrimary.withValues(alpha: 0.2),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'No habits yet',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.inversePrimary.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                _SectionHeader(title: 'Pending', count: pending.length),
                if (pending.isEmpty)
                  _AllDoneBanner()
                else
                  ...pending.map(
                    (habit) => HabitTile(
                      habit: habit,
                      onEdit: () => _openEditSheet(habit),
                    ),
                  ),
                const SizedBox(height: 16),
                if (completed.isNotEmpty) ...[
                  _SectionHeader(title: 'Completed', count: completed.length),
                  ...completed.map(
                    (habit) => HabitTile(
                      habit: habit,
                      onEdit: () => _openEditSheet(habit),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

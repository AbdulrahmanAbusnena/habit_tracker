import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/providers/habit_provider.dart';
import 'package:habit_tracker/shared/widgets/drawer.dart';
import 'package:habit_tracker/shared/widgets/floatingbutton.dart';
import 'package:provider/provider.dart';
import '../domain/models/habit.dart';
import '../shared/widgets/habit_tile.dart';
import '../shared/widgets/edit_habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openEditSheet(Habit habit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditHabitBox(habit: habit),
    );
  }

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

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;

  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.inversePrimary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              '$count',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AllDoneBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text('🎉', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              'All done for today!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Come back tomorrow',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../domain/models/habit.dart';
import '../../domain/providers/habit_provider.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onEdit;

  const HabitTile({super.key, required this.habit, required this.onEdit});
  static const List<Color> _colors = [
    Color(0xFF7C6FF7),
    Color(0xFF4CAF82),
    Color(0xFFE8834A),
    Color(0xFF4A9FD4),
    Color(0xFFE8B84A),
    Color(0xFFD45A7A),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[habit.colorIndex % _colors.length];
    final isDone = habit.isCompletedToday;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Slidable(
        key: ValueKey(habit.id),
        // we don't want it to left to right: so null.
        startActionPane: null,
        // right to left
        endActionPane: ActionPane(
          motion: const DrawerMotion(),

          extentRatio: 0.45, // how much of the action takes up

          children: [
            // edit action
            SlidableAction(
              onPressed: (_) => onEdit(),
              icon: Icons.edit_outlined,
              label: 'Edit',
              backgroundColor: Color(0xFF4A9FD4),
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
            // delete action
            SlidableAction(
              onPressed: (_) => _confirmDelete(context),
              backgroundColor: const Color(0xFFD45A7A),
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Delete',
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(12),
              ),
            ),
          ],
        ),
        // Now the Tile itself
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 5,

                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      habit.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        // Strike through when completed
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: isDone
                            ? Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.4)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 13,
                          color: color,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${habit.currentStreak} day streak',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () => context.read<HabitProvider>().toggleToday(habit),
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? color : Colors.transparent,
                        border: Border.all(
                          color: isDone
                              ? color
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: isDone
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // deleting confirmation
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: Text(
          '"${habit.name}" and all its history will be permanently deleted.',
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<HabitProvider>().deleteHabit(habit.id!);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFD45A7A)),
            ),
          ),
        ],
      ),
    );
  }
}

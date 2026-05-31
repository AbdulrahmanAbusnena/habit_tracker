import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../domain/models/habit.dart';
import '../../domain/providers/habit_provider.dart';
import '../../data/habit_database.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onEdit;

  HabitTile({super.key, required this.habit, required this.onEdit});
  static const List<Color> _colors = [
    Color(0xFF7C6FF7), // purple
    Color(0xFF4CAF82), // teal
    Color(0xFFE8834A), // coral
    Color(0xFF4A9FD4), // blue
    Color(0xFFE8B84A), // amber
    Color(0xFFD45A7A), // pink
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[habit.colorIndex % _colors.length];
    final isDone = habit.isCompletedToday;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      //  child: Slidable(),
    );
  }
}

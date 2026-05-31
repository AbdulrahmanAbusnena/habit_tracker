import 'package:flutter/material.dart';
import 'package:habit_tracker/shared/widgets/add_habit.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  void _openAddHabit() {
    showModalBottomSheet(
      context: context,
      // lets sheet resize
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddHabit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _openAddHabit,
      elevation: 0.9,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}

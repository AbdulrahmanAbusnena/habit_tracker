import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/habits/domain/models/habit.dart';
import '../../features/habits/domain/providers/habit_provider.dart';

class EditHabitBox extends StatefulWidget {
  final Habit habit; // the habit being edited

  const EditHabitBox({super.key, required this.habit});

  @override
  State<EditHabitBox> createState() => _EditHabitBoxState();
}

class _EditHabitBoxState extends State<EditHabitBox> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Pre-fill with the existing name
    // This is why we use initState — widget.habit is available here
    // You can't access widget.habit in the field declaration
    _nameController = TextEditingController(text: widget.habit.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    // copyWith creates a new Habit with the updated name
    // everything else — id, completedDays, streak — stays identical
    final updated = widget.habit.copyWith(name: name);

    context.read<HabitProvider>().updateHabit(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Edit Habit', style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 16),

          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Habit name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),

          const SizedBox(height: 16),

          FilledButton(onPressed: _submit, child: const Text('Save Changes')),
        ],
      ),
    );
  }
}

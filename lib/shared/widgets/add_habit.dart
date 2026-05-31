import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  // Controls the text field
  final _nameController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();

    // simple error handling, don't save if the user typed nothing or only typed a space
    if (name.isEmpty) return;

    // Calling the provider so theyt can save this to the DB and update list
    context.read<HabitProvider>().addHabit(name);

    // close the sheet
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
          Text(
            'Add a New Habit',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Habit Name',
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(),
            ),
            // Then tapping "done" and then the keyboard
            onSubmitted: (_) => _submit(),
          ),

          const SizedBox(height: 16),

          FilledButton(
            onPressed: _submit,
            child: Text('Add Habit', style: GoogleFonts.montserrat()),
          ),
        ],
      ),
    );
  }
}

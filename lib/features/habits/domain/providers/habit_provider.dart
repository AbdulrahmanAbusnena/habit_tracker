// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:habit_tracker/features/habits/data/habit_database.dart';

class HabitProvider extends ChangeNotifier {
  final HabitDatabase _db = HabitDatabase.instance;

  List<Habit> _habits = [];
  List<Habit> get habits => _habits;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // called when the App starts
  Future<void> loadHabits() async {
    _isLoading = true;
    notifyListeners();

    _habits = await _db.getAll();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addHabit(
    String name, {
    String? description,
    int colorIndex = 0,
  }) async {
    final habit = Habit(
      name: name,
      description: description,
      colorIndex: colorIndex,
      createdAt: DateTime.now(),
    );
    final saved = await _db.insert(habit);
    _habits.insert(0, saved);
    notifyListeners();
  }

  // Update method
  Future<void> updateHabit(Habit habit) async {
    await _db.update(habit);
    final index = _habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      _habits[index] = habit;
      notifyListeners();
    }
  }
  // Delete method

  Future<void> deleteHabit(int id) async {
    await _db.delete(id);
    _habits.removeWhere((h) => h.id == id);
    notifyListeners();
  }

  // Domain ops method
  Future<void> toggleToday(Habit habit) async {
    await _db.toggleToday(habit);

    final updated = await _db.getById(habit.id!);

    if (updated != null) {
      // ignore: unused_local_variable
      final index = _habits.indexWhere((h) => h.id == habit.id);

      _habits[index] = updated;
      notifyListeners();
    }
  }

  Map<DateTime, int> heatmapData() {
    final Map<DateTime, int> counts = {};

    for (final habit in _habits) {
      for (final dateStr in habit.completedDays) {
        final parts = dateStr.split('-');
        final date = DateTime(
          int.parse(parts[0]), // year
          int.parse(parts[1]), // month
          int.parse(parts[2]), // day
        );
        counts[date] = (counts[date] ?? 0) + 1;
      }
    }

    return counts;
  }
}

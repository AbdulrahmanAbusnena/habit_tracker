// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'package:habit_tracker/data/habit_database.dart';

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
}

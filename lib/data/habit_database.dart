import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:habit_tracker/domain/models/habit.dart';

class HabitDatabase {
  // private const
  HabitDatabase._();
  static final HabitDatabase instance = HabitDatabase._();
  // initializing the database
  Database? _db;

  Future<Database> get db async {
    // If already open, return it immediately
    _db ??= await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'habit_tracker.db');

    return openDatabase(
      path,
      version: 1,
      // onCreate runs once here
      // this is where I'm going to define the schema
      onCreate: (db, version) async {
        await db.execute('''
      CREATE table Habits ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      description TEXT,
      colorIndex INTEGER NOT NULL DEFAULT 0,
      createdAt TEXT NOT NULL,
      completedDays TEXT NOT NULL DEFAULT ''
      ) 

''');
      },
    );
  }

  // Let's start with CRUD
}

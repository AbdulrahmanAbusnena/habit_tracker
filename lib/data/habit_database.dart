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

  // CRUD

  // CREATE

  Future<Habit> insert(Habit habit) async {
    final database = await db;
    // this is where the insert is going to return an auto generated db (hope it works)
    final id = await database.insert('habits', habit.toMap());
    return habit.copyWith(id: id);
  }

  // Read

  Future<List<Habit>> getAll() async {
    final database = await db;
    final rows = await database.query('habits', orderBy: 'createdAt DESC');
    return rows.map(Habit.fromMap).toList();
  }

  Future<Habit?> getById(int id) async {
    final database = await db;
    final rows = await database.query(
      'habits',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Habit.fromMap(rows.first);
  }

  // Update
  Future<void> update(Habit habit) async {
    final database = await db;
    await database.update(
      'habits',
      habit.toMap(),
      where: 'id = ?',
      whereArgs: [habit.id],
    );
  }

  // Delete
  Future<void> toggleToday(Habit habit) async {
    final key = Habit.dateKey(DateTime.now());
    final days = List<String>.from(habit.completedDays);

    if (days.contains(key)) {
      days.remove(key);
    } else {
      days.add(key);
    }
  }
}

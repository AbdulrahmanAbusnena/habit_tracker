class Habit {
  final int? id;
  final String name;
  final String? description;
  final int colorIndex;
  final DateTime createdAt;
  final List<String> completedDays;

  Habit({
    this.id,
    required this.name,
    this.description,
    this.colorIndex = 0,
    required this.createdAt,
    List<String>? completedDays,
  }) : completedDays = completedDays ?? [];

  // DB conversion
  // SQLite can't store a list (duh uh) so the approah I found was joining it into one string

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'colorIndex': colorIndex,
    /* toIso8601String() is a format structure that strictly follows yyyy-MM-ddThHH:mm 
   or whatever and it's database friendtly, because we can't use Dart's Dart and TIme 
   */
    'createdAt': createdAt.toIso8601String(),
    // .join(), method creates a single string by placing a specfic connector between items (I'm using it to connect the dates in the list)
    'completedDays': completedDays.join(','),
  };

  // fromMap() is the reverse, meaning now from Map > habit
  // factory refers to a constructor that returns an instance but can run logic before returnng

  factory Habit.fromMap(Map<String, dynamic> map) => Habit(
    id: map['id'] as int?,
    name: map['name'] as String,
    description: map['description'] as String?,
    createdAt: DateTime.parse(map['createdAt'] as String),
    completedDays: (map['completedDays'] as String).isEmpty
        ? []
        : (map['completedDays'] as String).split(','),
  );

  bool get isCompletedToday =>
      completedDays.contains(Habit.dateKey(DateTime.now()));

  int get currentStreak {
    int streak = 0;
    DateTime day = DateTime.now();
    while (completedDays.contains(dateKey(day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  int get totalCompletions => completedDays.length;

  // Returns a copy with speciic fields changed
  // we need this because the class is immutable because of the final fields aboce

  Habit copyWith({
    int? id,
    String? name,
    String? description,
    int? colorIndex,
    DateTime? createdAt,
    List<String>? completedDays,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    colorIndex: colorIndex ?? this.colorIndex,
    createdAt: createdAt ?? this.createdAt,
    completedDays: completedDays ?? this.completedDays,
  );

  static String dateKey(DateTime date) =>
      '${date.year}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

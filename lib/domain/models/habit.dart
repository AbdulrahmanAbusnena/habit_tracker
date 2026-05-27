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
}

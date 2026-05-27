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
}

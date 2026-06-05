import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/features/habits/domain/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class Heatmap extends StatelessWidget {
  const Heatmap({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();
    final datasets = provider.heatmapData();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: Theme.of(
                context,
              ).colorScheme.inversePrimary.withValues(alpha: 0.5),
            ),
          ),

          const SizedBox(height: 10),

          HeatMapCalendar(
            flexible: true,
            colorMode: ColorMode.opacity,
            initDate: DateTime.now().subtract(const Duration(days: 180)),
            datasets: datasets,
            colorsets: const {
              1: Color(0xFF7C6FF7),
              2: Color(0xFF7C6FF7),
              3: Color(0xFF7C6FF7),
              4: Color(0xFF7C6FF7),
              5: Color(0xFF7C6FF7),
            },
            defaultColor: Color(0xFF2A2A3A),
            textColor: Colors.white54,
            weekTextColor: Colors.white38,
            borderRadius: 4,
            fontSize: 10,
            monthFontSize: 13,
            size: 18,
            margin: const EdgeInsets.all(3),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF1E1E2C)),
        ],
      ),
    );
  }
}

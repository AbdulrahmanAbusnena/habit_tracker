import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class Heatmap extends StatelessWidget {
  const Heatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      colorsets: const {
        1: Colors.green,
        2: Colors.lightGreen,
        3: Colors.lime,
        4: Colors.yellow,
      },
    );
  }
}

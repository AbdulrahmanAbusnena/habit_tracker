import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}

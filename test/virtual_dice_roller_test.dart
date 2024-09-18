import 'package:flutter/material.dart';

import 'package:virtual_dice_roller/virtual_dice_roller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VirtualDiceRollerScreen(),
    );
  }
}


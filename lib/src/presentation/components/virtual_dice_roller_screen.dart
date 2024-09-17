import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/virtual_dice_roller_widget.dart';

class VirtualDiceRollerScreen extends StatelessWidget {
  const VirtualDiceRollerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lắc xí ngầu')),
      body: VirtualDiceRollerWidget(),
    );
  }
}

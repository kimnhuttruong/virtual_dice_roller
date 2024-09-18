import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/virtual_dice_roller_widget.dart';

class VirtualDiceRollerScreen extends StatelessWidget {
  const VirtualDiceRollerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff087345)
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: ()=>{
            Navigator.of(context).pop()
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text('Lắc vật phẩm',style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Color(0xff087345)
        ),)),
      
      body: VirtualDiceRollerWidget(),
    );
  }
}

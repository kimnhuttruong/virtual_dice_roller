import 'package:flutter/material.dart';

class CustomDiceFace extends StatelessWidget {
  CustomDiceFace(
      {super.key,
      required this.widthAndHeight,
      this.transform,
      this.alignment,
      required this.number});
  Matrix4? transform;
  int number;
  Alignment? alignment;
  final double widthAndHeight;

  @override
  Widget build(BuildContext context) {
    String diceNumber = "";
    switch (number) {
      case 1:
        diceNumber = "dice_1.png";
        break;
      case 2:
        diceNumber = "dice_2.png";
        break;
      case 3:
        diceNumber = "dice_3.png";
        break;
      case 4:
        diceNumber = "dice_4.png";
        break;
      case 5:
        diceNumber = "dice_5.png";
        break;
      case 6:
        diceNumber = "dice_6.png";
        break;
    }
    return transform != null
        ? Transform(
            alignment: alignment,
            transform: transform!,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/$diceNumber"))),
              width: widthAndHeight,
              height: widthAndHeight,
            ),
          )
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/$diceNumber"))),
            width: widthAndHeight,
            height: widthAndHeight,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        diceNumber = "pb_1.png";
        break;
      case 2:
        diceNumber = "pb_2.png";
        break;
      case 3:
        diceNumber = "pb_3.png";
        break;
      case 4:
        diceNumber = "pb_4.png";
        break;
      case 5:
        diceNumber = "pb_5.png";
        break;
      case 6:
        diceNumber = "pb_6.png";
        break;
    }
    return transform != null
        ? Transform(
            alignment: alignment,
            transform: transform!,
            child: CubeCustom(
                widthAndHeight: widthAndHeight, diceNumber: diceNumber),
          )
        : CubeCustom(widthAndHeight: widthAndHeight, diceNumber: diceNumber);
  }
}

class CubeCustom extends StatelessWidget {
  const CubeCustom({
    super.key,
    required this.widthAndHeight,
    required this.diceNumber,
  });

  final double widthAndHeight;
  final String diceNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(10, 10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: Offset(-10, -10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        // Hiệu ứng nâng khối 3D
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade100,
          ],
        ),
      ),
      width: widthAndHeight,
      height: widthAndHeight,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/$diceNumber"))),
      ),
    );
  }
}

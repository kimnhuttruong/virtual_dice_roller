import 'package:flutter/material.dart';

class DiceFacePainter extends CustomPainter {
  final int number;

  DiceFacePainter(this.number);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final double dotRadius = 8.0;
    final double spacing = 25.0;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    switch (number) {
      case 1:
        canvas.drawCircle(Offset(centerX, centerY), dotRadius, paint);
        break;
      case 2:
        canvas.drawCircle(Offset(centerX - spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY + spacing), dotRadius, paint);
        break;
      case 3:
        canvas.drawCircle(Offset(centerX - spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY + spacing), dotRadius, paint);
        break;
      case 4:
        canvas.drawCircle(Offset(centerX - spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX - spacing, centerY + spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY + spacing), dotRadius, paint);
        break;
      case 5:
        canvas.drawCircle(Offset(centerX - spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY), dotRadius, paint);
        canvas.drawCircle(Offset(centerX - spacing, centerY + spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY + spacing), dotRadius, paint);
        break;
      case 6:
        canvas.drawCircle(Offset(centerX - spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY - spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX - spacing, centerY + spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY + spacing), dotRadius, paint);
        canvas.drawCircle(Offset(centerX + spacing, centerY + spacing), dotRadius, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

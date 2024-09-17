import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:html' as html;

class VirtualDiceRollerWidget extends StatefulWidget {
  @override
  _VirtualDiceRollerWidgetState createState() => _VirtualDiceRollerWidgetState();
}

class _VirtualDiceRollerWidgetState extends State<VirtualDiceRollerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationXAnimation;
  late Animation<double> _rotationYAnimation;
  late Animation<double> _rotationZAnimation;
  final Random _random = Random();
  int _currentDiceNumber = 1;
  List<int> numbers = [1, 2, 3, 4, 5, 6];
  ShakeDetector? _shakeDetector;
  @override
  void initState() {
    super.initState();

    Random random = Random();
    numbers.shuffle(random);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Rotation animations for X, Y, and Z axes
    _rotationXAnimation = Tween<double>(begin: 0, end: 5 * pi)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    _rotationYAnimation = Tween<double>(begin: 0, end: 5 * pi)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    _rotationZAnimation = Tween<double>(begin: 0, end: 5 * pi)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
    html.window.onMessage.listen((event) {
      if (event.data == 'onShakeDetected') {
        _shakeDice();
        print('Shake detected!');
        // Xử lý sự kiện lắc trong ứng dụng Flutter của bạn
      }
    });
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: () {
        // Handle shake event here
        _shakeDice();
        print('Phone shaken!');
      },
    );
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    _controller.dispose();
    super.dispose();
  }

  // Function to shake and rotate the dice
  void _shakeDice() {
    _controller.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Random random = Random();
        numbers.shuffle(random);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_rotationXAnimation.value)
                  ..rotateY(_rotationYAnimation.value)
                  ..rotateZ(_rotationZAnimation.value),
                child: Stack(
                  children: [
                    // Rear faces are drawn first to be behind other faces
                    _buildDiceFace(numbers[5], Colors.white, 0, -pi, 0), // Back
                    _buildDiceFace(numbers[4], Colors.white, 0, 0, 0), // Front
                    _buildDiceFace(numbers[2], Colors.white, 0, pi / 2, 0), // Right
                    _buildDiceFace(numbers[3], Colors.white, 0, -pi / 2, 0), // Left
                    _buildDiceFace(numbers[1], Colors.white, -pi / 2, 0, 0), // Bottom
                    _buildDiceFace(numbers[0], Colors.white, pi / 2, 0, 0), // Top
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: _shakeDice,
          child: Text('Shake Dice'),
        ),
      ],
    );
  }

  // Function to build each face of the dice cube
  Widget _buildDiceFace(int number, Color color, double rotateX, double rotateY, double rotateZ) {
    return Transform(
      transform: Matrix4.identity()
        ..rotateX(rotateX)
        ..rotateY(rotateY)
        ..rotateZ(rotateZ)
        ..translate(0.0, 0.0, 50.0), // Distance from center to make it 3D
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: CustomPaint(
          painter: DiceFacePainter(number),
        ),
      ),
    );
  }
}

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

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shake/shake.dart';
import 'dart:html' as html;
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:virtual_dice_roller/src/presentation/components/dice_face.dart';

class VirtualDiceRollerWidget extends StatefulWidget {
  @override
  _VirtualDiceRollerWidgetState createState() =>
      _VirtualDiceRollerWidgetState();
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
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Random random = Random();
        numbers.shuffle(random);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const widthAndHeight = 100.0;
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
                    // buildDiceFace(numbers[5], Colors.white, 0, -pi, 0), // Back
                    // buildDiceFace(numbers[4], Colors.black, 0, 0, 0), // Front
                    // buildDiceFace(numbers[2], Colors.orange, 0, pi / 2, 0), // Right
                    // buildDiceFace(numbers[3], Colors.red, 0, -pi / 2, 0), // Left
                    // buildDiceFace(numbers[1], Colors.blue, -pi / 2, 0, 0), // Bottom
                    // buildDiceFace(numbers[0], Colors.pink, pi / 2, 0, 0), // Top

                    // // back
                    //   buildDiceFace(numbers[5], Matrix4.identity()
                    //       ..translate(Vector3(0, 0, -widthAndHeight)), Alignment.center,),
                    //   // left side
                    //   buildDiceFace(numbers[4], Matrix4.identity()..rotateY(pi / 2.0),Alignment.centerLeft ),

                    //   // left side
                    //   buildDiceFace(numbers[3], Matrix4.identity()..rotateY(-pi / 2.0),Alignment.centerRight),

                    //   // front
                    //   buildDiceFace(numbers[2], null,null),
                    //   // top side
                    //   buildDiceFace(numbers[1], Matrix4.identity()..rotateX(-pi / 2.0),Alignment.topCenter,),

                    //   // bottom side
                    //   buildDiceFace(numbers[0], Matrix4.identity()..rotateX(pi / 2.0),Alignment.bottomCenter),
                    CustomDiceFace(
                      number: numbers[5],
                      alignment: Alignment.center,
                      widthAndHeight: widthAndHeight,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -widthAndHeight)),
                    ),

                    // left side
                    CustomDiceFace(
                      number: numbers[4],
                      alignment: Alignment.centerLeft,
                      widthAndHeight: widthAndHeight,
                      transform: Matrix4.identity()..rotateY(pi / 2.0),
                    ),

                    // left side
                    CustomDiceFace(
                      number: numbers[3],
                      alignment: Alignment.centerRight,
                      widthAndHeight: widthAndHeight,
                      transform: Matrix4.identity()..rotateY(-pi / 2.0),
                    ),
                    // front
                    CustomDiceFace(
                      number: numbers[2],
                      widthAndHeight:widthAndHeight ,
                    ),

                    // top side
                    CustomDiceFace(
                      number: numbers[1],
                      alignment: Alignment.topCenter,
                      widthAndHeight: widthAndHeight,
                      transform: Matrix4.identity()..rotateX(-pi / 2.0),
                    ),

                    // bottom side
                    CustomDiceFace(
                      number: numbers[0],
                      alignment: Alignment.bottomCenter,
                      widthAndHeight: widthAndHeight,
                      transform: Matrix4.identity()..rotateX(pi / 2.0),
                    )
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
}

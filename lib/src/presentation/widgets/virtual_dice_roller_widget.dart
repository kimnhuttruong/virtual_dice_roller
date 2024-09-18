import 'dart:math';
import 'package:flutter/cupertino.dart';
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
  int rewardPoint = 2;
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
    const widthAndHeight = 200.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Stack(children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Image(
                              image:
                                  AssetImage('assets/images/source_1.png')))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Image(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/source_2.png')))),
                  Align(
                    alignment: Alignment.center,
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
                                transform: Matrix4.identity()
                                  ..rotateY(pi / 2.0),
                              ),

                              // left side
                              CustomDiceFace(
                                number: numbers[3],
                                alignment: Alignment.centerRight,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateY(-pi / 2.0),
                              ),
                              // front
                              CustomDiceFace(
                                number: numbers[2],
                                widthAndHeight: widthAndHeight,
                              ),

                              // top side
                              CustomDiceFace(
                                number: numbers[1],
                                alignment: Alignment.topCenter,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateX(-pi / 2.0),
                              ),

                              // bottom side
                              CustomDiceFace(
                                number: numbers[0],
                                alignment: Alignment.bottomCenter,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateX(pi / 2.0),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mỗi lượt quay cần "),
                      Text(
                        "$rewardPoint điểm thưởng",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff087345)),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _shakeDice,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Color(0xff087345)),
                      child: Text('Lắc ngay',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff087345))),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: Text('Quay về trang chủ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

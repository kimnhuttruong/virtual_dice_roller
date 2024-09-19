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
  String celebration = "celebration.png";
  int _currentDiceNumber = 1;
  int rewardPoint = 2;
  List<int> numbers = [1, 2, 3, 4, 5, 6];
  ShakeDetector? _shakeDetector;
  Map<int, String> facesDiceImg = {
    1: "https://i.ibb.co/jZ9rZN2/458773052-1211439429984303-5754649544639617371-n.png",
    2: "https://i.ibb.co/3CcnQrY/458720770-1052503942950905-9154611876704126876-n.png",
    3: "https://i.ibb.co/smXM5BY/459236769-556535163604970-1113617706066173765-n.png",
    4: "https://i.ibb.co/2P4GLP4/458753606-507836735210198-5500733764522750099-n.png",
    5: "https://i.ibb.co/jJqvCYG/459251379-489518600557795-143072884890981896-n.png",
    6: "https://i.ibb.co/BHJ2KN9/459182922-585503570469002-1568941098303412007-n.png",
  };

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

  Future<String?> fetchApi() async {
    Random random = Random();
    numbers.shuffle(random);
    return facesDiceImg[numbers[2]];
  }

  // Function to shake and rotate the dice
  Future<void> _shakeDice() async {
    _controller.repeat();

    setState(() {
      celebration = "celebration.gif";
    });

    //wait api
    String? rs = await Future.delayed(
      Duration(seconds: 1),
      () async {
        return await fetchApi();
      },
    );
    setState(() {
      facesDiceImg[3] = rs!;
    });

    _controller.stop();
    _controller.forward(from: 0);

    // show popup
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
                                  AssetImage('assets/images/$celebration')))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Image(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/$celebration')))),
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
                                alignment: Alignment.center,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..translate(Vector3(0, 0, -widthAndHeight)),
                                imgUrl: facesDiceImg[6],
                              ),

                              // left side
                              CustomDiceFace(
                                alignment: Alignment.centerLeft,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateY(pi / 2.0),
                                imgUrl: facesDiceImg[5],
                              ),

                              // left side
                              CustomDiceFace(
                                alignment: Alignment.centerRight,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateY(-pi / 2.0),
                                imgUrl: facesDiceImg[4],
                              ),
                              // front
                              CustomDiceFace(
                                widthAndHeight: widthAndHeight,
                                imgUrl: facesDiceImg[3],
                              ),

                              // top side
                              CustomDiceFace(
                                alignment: Alignment.topCenter,
                                widthAndHeight: widthAndHeight,
                                transform: Matrix4.identity()
                                  ..rotateX(-pi / 2.0),
                                imgUrl: facesDiceImg[2],
                              ),

                              // bottom side
                              CustomDiceFace(
                                  alignment: Alignment.bottomCenter,
                                  widthAndHeight: widthAndHeight,
                                  transform: Matrix4.identity()
                                    ..rotateX(pi / 2.0),
                                  imgUrl: facesDiceImg[1]),
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
                      onPressed: () async {
                        await _shakeDice();
                      },
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

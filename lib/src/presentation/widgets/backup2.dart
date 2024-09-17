// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class VirtualDiceRollerWidget extends StatefulWidget {
//   @override
//   _VirtualDiceRollerWidgetState createState() => _VirtualDiceRollerWidgetState();
// }

// class _VirtualDiceRollerWidgetState extends State<VirtualDiceRollerWidget> {
//   final List<Widget> _list = <Widget>[];
//   final double _size = 140.0;
//   double _x = pi * 0.25, _y = pi * 0.25;
//   late Timer _timer;
//   int _currentRoll = 1;

//   int get size => _list.length;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         // Rainbow effect for the cubes
//         LayoutBuilder(
//           builder: (_, BoxConstraints constraints) {
//             return Stack(
//               children: _list.map((Widget cube) {
//                 final int index = _list.indexOf(cube);
//                 final double i = map(size - index, 0, 150) * 100;
//                 return Positioned(
//                   top: (constraints.maxHeight / 2 - _size / 2) + i * constraints.maxHeight * 0.9,
//                   left: (constraints.maxWidth / 2 - _size / 2) - i * constraints.maxWidth * 0.9,
//                   child: Transform.scale(scale: i * 1.5 + 1.0, child: cube),
//                 );
//               }).toList(),
//             );
//           },
//         ),

//         // Dice interaction
//         GestureDetector(
//           onPanUpdate: (DragUpdateDetails update) {},
//           child: Container(
//             color: Colors.transparent,
//             child: Cube(
//               color: Colors.grey.shade200,
//               x: _x,
//               y: _y,
//               size: _size,
//               result: _currentRoll,
//             ),
//           ),
//         ),

//         // Roll button
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: ElevatedButton(
//             onPressed: _rollDice,
//             child: Text('Roll Dice'),
//           ),
//         ),
//       ],
//     );
//   }

//   int _elapsedMilliseconds = 0;
//   _rollDice() {
//     // Reset elapsed time
//     _elapsedMilliseconds = 0;

//     // Start a new timer
//     _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
//       setState(() {
//         _x = (_x + -10 / 150) % (pi * 2);
//         _y = (_y + -10 / 150) % (pi * 2);
//         _elapsedMilliseconds += 10; // Increment the elapsed time

//         if (_elapsedMilliseconds >= 2000) {
//           // Check if 5 seconds have passed
//           _timer?.cancel(); // Stop the timer
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   // void _rollDice() {
//   //   if (_timer.isActive) return;

//   //   setState(() {
//   //     _currentRoll = Random().nextInt(6) + 1; // Roll the dice (1 to 6)
//   //   });

//   //   _timer = Timer.periodic(const Duration(milliseconds: 48), (_) => _addCube());
//   // }

//   void _addCube() {
//     if (size > 150) {
//       _list.removeRange(0, Colors.accents.length * 4);
//     }

//     setState(() {
//       _list.add(Cube(
//         x: _x,
//         y: _y,
//         color: Colors.accents[_timer.tick % Colors.accents.length].withOpacity(0.2),
//         rainbow: true,
//         size: _size,
//         result: _currentRoll,
//       ));
//     });
//   }
// }

// class Cube extends StatelessWidget {
//   const Cube({
//     Key? key,
//     required this.x,
//     required this.y,
//     required this.color,
//     required this.size,
//     this.rainbow = false,
//     required this.result,
//   }) : super(key: key);

//   static const double _shadow = 0.2;
//   static const double _halfPi = pi / 2;
//   static const double _oneHalfPi = pi + _halfPi;

//   final double x, y, size;
//   final Color color;
//   final bool rainbow;
//   final int result;

//   double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

//   @override
//   Widget build(BuildContext context) {
//     final bool topBottom = x < _halfPi || x > _oneHalfPi;
//     final bool northSouth = _sum < _halfPi || _sum > _oneHalfPi;
//     final bool eastWest = _sum < pi;

//     return Stack(
//       children: <Widget>[
//         _side(zRot: y, xRot: -x, shadow: _getShadow(x).toDouble(), moveZ: topBottom),
//         _side(yRot: y, xRot: _halfPi - x, shadow: _getShadow(_sum).toDouble(), moveZ: northSouth),
//         _side(
//           yRot: -_halfPi + y,
//           xRot: _halfPi - x,
//           shadow: _shadow - _getShadow(_sum),
//           moveZ: eastWest,
//         ),
//         Positioned(
//           bottom: 10,
//           right: 10,
//           child: Text(
//             result.toString(),
//             style: TextStyle(
//               fontSize: 24,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   num _getShadow(double r) {
//     if (r < _halfPi) {
//       return map(r, 0, _halfPi, 0, _shadow);
//     } else if (r > _oneHalfPi) {
//       return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
//     } else if (r < pi) {
//       return _shadow - map(r, _halfPi, pi, 0, _shadow);
//     }

//     return map(r, pi, _oneHalfPi, 0, _shadow);
//   }

//   Widget _side({
//     bool moveZ = true,
//     double xRot = 0.0,
//     double yRot = 0.0,
//     double zRot = 0.0,
//     double shadow = 0.0,
//   }) {
//     return Transform(
//       alignment: Alignment.center,
//       transform: Matrix4.identity()
//         ..rotateX(xRot)
//         ..rotateY(yRot)
//         ..rotateZ(zRot)
//         ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
//       child: Container(
//         alignment: Alignment.center,
//         child: Container(
//           constraints: BoxConstraints.expand(width: size, height: size),
//           color: color,
//           foregroundDecoration: BoxDecoration(
//             color: Colors.black.withOpacity(rainbow ? 0.0 : shadow),
//             border: Border.all(
//               width: 0.8,
//               color: rainbow ? color.withOpacity(0.3) : Colors.black26,
//             ),
//           ),
//           child: const FlutterLogo(size: 200),
//         ),
//       ),
//     );
//   }
// }

// num map(num value, [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
//     ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

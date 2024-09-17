// import 'dart:math';
// import 'package:flutter/material.dart';

// class VirtualDiceRollerWidget extends StatefulWidget {
//   @override
//   _VirtualDiceRollerWidgetState createState() => _VirtualDiceRollerWidgetState();
// }

// class _VirtualDiceRollerWidgetState extends State<VirtualDiceRollerWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationXAnimation;
//   late Animation<double> _rotationYAnimation;
//   late Animation<double> _rotationZAnimation;
//   final Random _random = Random();
//   int _currentDiceNumber = 1;
//   List<int> numbers = [1, 2, 3, 4, 5, 6];
//   @override
//   void initState() {
//     super.initState();
//     Random random = Random();
//     numbers.shuffle(random);
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );

//     // Rotation animations for X, Y, and Z axes
//     _rotationXAnimation = Tween<double>(begin: 0, end: 4 * pi)
//         .chain(CurveTween(curve: Curves.easeInOut))
//         .animate(_controller);

//     _rotationYAnimation = Tween<double>(begin: 0, end: 4 * pi)
//         .chain(CurveTween(curve: Curves.easeInOut))
//         .animate(_controller);

//     _rotationZAnimation = Tween<double>(begin: 0, end: 4 * pi)
//         .chain(CurveTween(curve: Curves.easeInOut))
//         .animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Function to shake and rotate the dice
//   void _shakeDice() {
//     _controller.forward(from: 0);
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         Random random = Random();
//         numbers.shuffle(random);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Transform(
//               alignment: Alignment.center,
//               transform: Matrix4.identity()
//                 ..rotateX(_rotationXAnimation.value)
//                 ..rotateY(_rotationYAnimation.value)
//                 ..rotateZ(_rotationZAnimation.value),
//               child: Stack(
//                 children: [
//                   _buildDiceFace(numbers[0], Colors.red, pi / 2, 0, 0), // Top
//                   _buildDiceFace(numbers[1], Colors.green, -pi / 2, 0, 0), // Bottom
//                   _buildDiceFace(numbers[2], Colors.blue, 0, pi / 2, 0), // Right
//                   _buildDiceFace(numbers[3], Colors.yellow, 0, -pi / 2, 0), // Left
//                   _buildDiceFace(numbers[4], Colors.purple, 0, 0, 0), // Front
//                   _buildDiceFace(numbers[5], Colors.orange, 0, pi, 0), // Back
//                 ],
//               ),
//             );
//           },
//         ),
//         SizedBox(height: 40),
//         ElevatedButton(
//           onPressed: _shakeDice,
//           child: Text('Shake Dice'),
//         ),
//       ],
//     );
//   }

//   // Function to build each face of the dice cube
//   Widget _buildDiceFace(int number, Color color, double rotateX, double rotateY, double rotateZ) {
//     return Transform(
//       transform: Matrix4.identity()
//         ..rotateX(rotateX)
//         ..rotateY(rotateY)
//         ..rotateZ(rotateZ)
//         ..translate(0.0, 0.0, 50.0), // Distance from center to make it 3D
//       alignment: Alignment.center,
//       child: Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: color,
//           border: Border.all(color: Colors.black, width: 2),
//         ),
//         child: Center(
//           child: Text(
//             '$number',
//             style: TextStyle(
//               fontSize: 48,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

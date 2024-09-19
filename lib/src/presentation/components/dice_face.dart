import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDiceFace extends StatelessWidget {
  CustomDiceFace({
    super.key,
    required this.widthAndHeight,
    this.transform,
    this.alignment,
    this.imgUrl,
  });
  Matrix4? transform;
  Alignment? alignment;
  String? imgUrl;
  final double widthAndHeight;

  @override
  Widget build(BuildContext context) {
    return transform != null
        ? Transform(
            alignment: alignment,
            transform: transform!,
            child: CubeCustom(widthAndHeight: widthAndHeight, url: imgUrl!),
          )
        : CubeCustom(widthAndHeight: widthAndHeight, url: imgUrl!);
  }
}

class CubeCustom extends StatelessWidget {
  const CubeCustom({
    super.key,
    required this.widthAndHeight,
    required this.url,
  });

  final double widthAndHeight;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthAndHeight,
      height: widthAndHeight,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff087345), width: 0.5),
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
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Colors.grey.shade300,
          //     Colors.grey.shade100,
          //   ],
          // ),

          color: Colors.white),
      child: Container(
        width: widthAndHeight * 0.8,
      height: widthAndHeight * 0.8,
       
        child: Image(fit: BoxFit.fill ,image: NetworkImage( url)),
      ),
    );
  }
}
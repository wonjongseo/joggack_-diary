import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  const ShadowText({super.key, required this.text, required this.fontSize});
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 테두리용 Text
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.black, // 테두리 색상
          ),
        ),
        // 안쪽 채우기용 Text
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white, // 텍스트 색상
          ),
        ),
      ],
    );
  }
}

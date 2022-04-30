import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;
  const CustomText({ required this.text, required this.textSize, required this.fontWeight, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(text ,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor,
      ),);
  }
}
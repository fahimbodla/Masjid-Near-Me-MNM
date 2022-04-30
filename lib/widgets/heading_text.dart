import 'package:flutter/material.dart';

import 'custom_text.dart';

class HeadingText extends StatelessWidget {
  final String heading;
  final String subHeading;

  const HeadingText({Key? key, required this.heading, required this.subHeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: heading,
            textSize: 21,
            fontWeight: FontWeight.bold,
            textColor: Colors.black),
        const SizedBox(height: 5,),
        CustomText(
            text: subHeading,
            textSize: 14,
            fontWeight: FontWeight.normal,
            textColor: Colors.black),
      ],
    );
  }
}

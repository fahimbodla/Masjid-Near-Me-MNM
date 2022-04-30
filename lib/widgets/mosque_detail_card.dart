
import 'package:flutter/material.dart';

import 'custom_text.dart';

class EventDetailCard extends StatelessWidget {
  final String text;
  final String icon;

  const EventDetailCard({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 14,
          width: 14,
          child: Image.asset("assets/images/${icon}"),
        ),
        const SizedBox(
          width: 4,
        ),
        Container(
          width: MediaQuery.of(context).size.width *0.5,
          child: CustomText(
              text: text,
              textSize: 13,
              fontWeight: FontWeight.normal,
              textColor: Color(0xff404040)),
        )
      ],
    );
  }
}

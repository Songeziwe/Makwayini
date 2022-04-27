import 'package:flutter/material.dart';
import 'package:quicloc/constants/theme.dart';

class CustomIcon extends StatefulWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        pressed = !pressed;
      }),
      child: pressed
          ? const Icon(
              Icons.star,
              color: kIconColor,
            )
          : const Icon(Icons.star_outline_outlined),
    );
  }
}

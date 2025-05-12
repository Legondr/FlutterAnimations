import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedShape extends StatefulWidget {
  const AnimatedShape({super.key, required this.isCircle});

  final bool isCircle;

  @override
  State<AnimatedShape> createState() => AnimatedShapeState();
}

class AnimatedShapeState extends State<AnimatedShape> {
  double size = 100.0;
  Color color = Colors.black;
  final Random random = Random();

  void animate() {
    setState(() {
      size = 100 + random.nextDouble() * 200; // Between 100 and 300
      color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(widget.isCircle ? size / 2 : 0),
          ),
        ),
      ],
    );
  }
}

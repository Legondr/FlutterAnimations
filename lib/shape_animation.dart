import 'package:flutter/material.dart';
import 'animated_shape.dart';

class ShapeAnimation extends StatelessWidget {
  ShapeAnimation({super.key});

  final GlobalKey<AnimatedShapeState> _circleKey =
      GlobalKey<AnimatedShapeState>();
  final GlobalKey<AnimatedShapeState> _squareKey =
      GlobalKey<AnimatedShapeState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedShape(key: _circleKey, isCircle: true),
        const SizedBox(height: 20),
        AnimatedShape(key: _squareKey, isCircle: false),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            _circleKey.currentState?.animate();
            _squareKey.currentState?.animate();
          },
          child: const Text("Animate Circle & Square"),
        ),
      ],
    );
  }
}

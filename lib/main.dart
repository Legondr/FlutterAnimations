import 'package:animations/animated_star.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

// Define ShapeAnimation widget first
class ShapeAnimation extends StatelessWidget {
  ShapeAnimation({super.key});

  final GlobalKey<AnimatedShapeState> _circleKey = GlobalKey();
  final GlobalKey<AnimatedShapeState> _squareKey = GlobalKey();

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

// Define AnimatedShape widget
class AnimatedShape extends StatefulWidget {
  const AnimatedShape({super.key, required this.isCircle});
  final bool isCircle;

  @override
  AnimatedShapeState createState() => AnimatedShapeState();
}

class AnimatedShapeState extends State<AnimatedShape> {
  double size = 100.0;
  Color color = Colors.black;
  final Random random = Random();

  void animate() {
    setState(() {
      size = 100 + random.nextDouble() * 200;
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
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(widget.isCircle ? size / 2 : 0),
      ),
    );
  }
}

// Then use ShapeAnimation in MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(children: [ShapeAnimation()]),
                Row(children: [AnimatedStarRow()]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedStarRow extends StatefulWidget {
  const AnimatedStarRow({super.key});

  @override
  State<AnimatedStarRow> createState() => _AnimatedStarRowState();
}

class _AnimatedStarRowState extends State<AnimatedStarRow>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scales;
  late final List<Animation<double>> _opacities;

  // Track if each star is "on" (lit up)
  late List<bool> _isStarOn;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(3, (i) {
      return AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
    });

    _scales =
        _controllers
            .map(
              (controller) =>
                  CurvedAnimation(parent: controller, curve: Curves.elasticOut),
            )
            .toList();

    _opacities =
        _controllers
            .map(
              (controller) =>
                  CurvedAnimation(parent: controller, curve: Curves.easeIn),
            )
            .toList();

    _isStarOn = List.generate(3, (_) => false); // all stars off initially
  }

  void toggleStar(int index) {
    setState(() {
      _isStarOn[index] = !_isStarOn[index]; // toggle the star
    });

    if (_isStarOn[index]) {
      _controllers[index].forward(from: 0); // animate in
    } else {
      _controllers[index].reverse(); // animate out
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () => toggleStar(index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.star, size: 48, color: Colors.grey),
                  AnimatedBuilder(
                    animation: _controllers[index],
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacities[index].value,
                        child: Transform.scale(
                          scale: _scales[index].value,
                          child: Icon(
                            Icons.star,
                            size: 48,
                            color: Colors.amber,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

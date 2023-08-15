import 'dart:math' as math;

import 'package:flutter/material.dart';

class Prediction extends StatelessWidget {
  const Prediction({
    required this.lightSource,
    required this.opacity,
    required this.angle,
    required this.text,
    super.key,
  });

  final Offset lightSource;
  final double opacity;
  final double angle;
  final String text;

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    final portalShadowOffset =
        Offset.fromDirection(math.pi + lightSource.direction, innerShadowWidth);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(portalShadowOffset.dx, portalShadowOffset.dy),
          colors: const [Color(0x661F1F1F), Colors.black],
          stops: [1 - innerShadowWidth, 1],
        ),
      ),
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

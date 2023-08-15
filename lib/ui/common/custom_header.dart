import 'package:flutter/material.dart';
import 'package:magic_ball_eight/ui/common/custom_clipper_header.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    required this.height,
    super.key,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperHeader(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: height,
      ),
    );
  }
}

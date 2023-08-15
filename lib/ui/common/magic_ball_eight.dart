import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_ball_eight/constants/predictions.dart';
import 'package:magic_ball_eight/ui/common/prediction.dart';
import 'package:magic_ball_eight/ui/question_answer/cubit/question_answer_cubit.dart';

class MagicBallEight extends StatefulWidget {
  const MagicBallEight({super.key});

  @override
  State<MagicBallEight> createState() => _MagicBallEightState();
}

class _MagicBallEightState extends State<MagicBallEight>
    with SingleTickerProviderStateMixin {
  static const restPosition = Offset(0, -0.15);
  static const lightSource = Offset(0, -0.75);

  late AnimationController animationController;
  late Animation<double> animation;

  String prediction = 'Agita para conocer tu destino';
  Offset position = Offset.zero;
  double wobble = 0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    animationController.addListener(() => setState(() {}));

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.elasticIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final windowPosition =
        Offset.lerp(restPosition, position, animation.value)!;
    final size = Size.square(MediaQuery.of(context).size.shortestSide);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BlocListener<QuestionAnswerCubit, QuestionAnswerState>(
          listenWhen: (previous, current) => !current.isInitial,
          listener: (context, state) {
            if (state.x != null || state.y != null) {
              _startShaking(Offset(state.x ?? 0, state.y ?? 0), size);
            } else {
              _stopShaking();
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: size.shortestSide,
            height: size.shortestSide,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.shade400,
            ),
            child: Transform(
              origin: size.center(Offset.zero),
              transform: Matrix4.identity()
                ..translate(
                  windowPosition.dx * size.width / 2,
                  windowPosition.dy * size.height / 2,
                )
                ..rotateZ(windowPosition.direction)
                ..rotateY(windowPosition.distance * math.pi / 2)
                ..rotateZ(-windowPosition.direction)
                ..scale(0.5 - 0.15 * windowPosition.distance),
              child: Prediction(
                lightSource: lightSource - windowPosition,
                opacity: 1 - animationController.value,
                angle: wobble,
                text: prediction,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _startShaking(Offset position, Size size) {
    animationController.forward(from: 0);
    var newPosition = Offset((2 * position.dx / size.width) - 1,
        (2 * position.dy / size.height) - 1);
    if (newPosition.distance > 0.8) {
      newPosition = Offset.fromDirection(newPosition.direction, 0.8);
    }
    setState(() => this.position = newPosition);
  }

  void _stopShaking() {
    final rand = math.Random();
    wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    prediction = predictions[rand.nextInt(predictions.length)];
    animationController.reverse(from: 1);
  }
}

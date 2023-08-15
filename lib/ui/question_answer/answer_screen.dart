import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_ball_eight/ui/common/magic_ball_eight.dart';
import 'package:magic_ball_eight/ui/question_answer/cubit/question_answer_cubit.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({
    required this.question,
    super.key,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionAnswerCubit()..startListen(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const MagicBallEight(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Haz otra pregunta',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

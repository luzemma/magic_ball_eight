import 'package:flutter/material.dart';
import 'package:magic_ball_eight/ui/common/custom_header.dart';
import 'package:magic_ball_eight/ui/question_answer/answer_screen.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                CustomHeader(height: constraints.maxHeight * 0.25),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '¡Pregúntame lo que quieras!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Escribe aquí tu pregunta',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            suffixIcon: IconButton(
                              onPressed: _textController.clear,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'El campo es obligatorio'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            await Navigator.of(context).push(
                              // ignore: inference_failure_on_instance_creation
                              MaterialPageRoute(
                                builder: (context) => AnswerScreen(
                                  question: _textController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Conoce tu destino',
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
              ],
            );
          },
        ),
      ),
    );
  }
}

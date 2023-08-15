import 'package:flutter/material.dart';
import 'package:magic_ball_eight/l10n/l10n.dart';
import 'package:magic_ball_eight/ui/question_answer/question_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: QuestionScreen(),
    );
  }
}

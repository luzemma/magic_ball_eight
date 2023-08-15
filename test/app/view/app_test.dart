import 'package:flutter_test/flutter_test.dart';
import 'package:magic_ball_eight/ui/app.dart';
import 'package:magic_ball_eight/ui/question_answer/question_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(QuestionScreen), findsOneWidget);
    });
  });
}

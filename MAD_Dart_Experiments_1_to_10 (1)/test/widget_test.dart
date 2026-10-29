import 'package:flutter_test/flutter_test.dart';
import 'package:mad_dart_experiments/practical_10_testing_and_deployment.dart';

void main() {
  test('addition works', () {
    expect(2 + 3, 5);
  });

  testWidgets('Deployment app displays launch message', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Flutter App Successfully Launched!'), findsOneWidget);
    expect(find.text('Goodbye'), findsNothing);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mad_practical1/main.dart';

void main() {
  testWidgets('Home page shows Dart concept output', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Krima | 24AIML027'), findsOneWidget);
    expect(find.text('Name: Rahul'), findsOneWidget);
  });

  test('add function works', () {
    expect(add(10, 20), 30);
  });
}

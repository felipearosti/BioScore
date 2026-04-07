import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Login screen renders with BioScore brand', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BioScoreApp());

    expect(find.text('BioScore'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}

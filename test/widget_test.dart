// Basic smoke test for the MT Alchemy prototype.

import 'package:flutter_test/flutter_test.dart';

import 'package:mt_alchemy/main.dart';

void main() {
  testWidgets('MT Alchemy app boots to Home', (WidgetTester tester) async {
    await tester.pumpWidget(const MtAlchemyApp());
    await tester.pumpAndSettle();

    expect(find.text('MT Alchemy'), findsWidgets);
    expect(find.textContaining('Elevate your value'), findsWidgets);
    expect(find.text('What We Do'), findsWidgets);
  });
}
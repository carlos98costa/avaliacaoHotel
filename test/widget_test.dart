import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hotel/main.dart';

void main() {
  testWidgets('cadastra uma nova hospedagem e exibe na lista',
      (WidgetTester tester) async {
    await tester.pumpWidget(const HotelApp());

    await tester.tap(find.text('Hospedagens'));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), '305');
    await tester.enterText(find.byType(TextField).at(1), '1250,50');
    await tester.tap(find.text('Confirmar hospedagem'));
    await tester.pumpAndSettle();

    expect(find.text('Quarto nº 305'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Quarto nº 305'), findsOneWidget);
    expect(find.textContaining('1.250,50'), findsOneWidget);
  });
}

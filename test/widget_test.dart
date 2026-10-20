import 'package:flutter_test/flutter_test.dart';
import 'package:scaffold/main.dart';

void main() {
  testWidgets('CMR Campus ERP app launches', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const CMRConnectApp());

    expect(find.byType(CMRConnectApp), findsOneWidget);
  });
}
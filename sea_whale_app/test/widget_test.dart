import 'package:flutter_test/flutter_test.dart';
import 'package:sea_whale_app/main.dart';

void main() {
  testWidgets('SeaWhaleApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SeaWhaleApp());
    await tester.pumpAndSettle();

    // Verify brand header is present
    expect(find.text('SEA WHALE'), findsOneWidget);

    // Verify navigation tabs
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Store'), findsOneWidget);
    expect(find.text('Pre-Order'), findsOneWidget);
    expect(find.text('Tracker'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:signtovoiceandtext/main.dart';

void main() {
  testWidgets('App loads and displays the correct title', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that the title is present
    expect(find.text('Sign to Voice & Text'), findsOneWidget);
  });
}

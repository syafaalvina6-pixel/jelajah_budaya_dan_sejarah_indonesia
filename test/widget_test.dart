import 'package:flutter_test/flutter_test.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
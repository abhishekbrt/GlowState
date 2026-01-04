import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowstate/app.dart';

void main() {
  testWidgets('GlowState app loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: GlowStateApp()));

    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
  });
}

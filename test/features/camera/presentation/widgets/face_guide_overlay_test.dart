import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowstate/features/camera/presentation/widgets/face_guide_overlay.dart';

void main() {
  group('FaceGuideOverlay', () {
    group('rendering', () {
      testWidgets('renders without errors', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: FaceGuideOverlay())),
        );

        // Assert
        expect(find.byType(FaceGuideOverlay), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(FaceGuideOverlay),
            matching: find.byType(CustomPaint),
          ),
          findsOneWidget,
        );
      });

      testWidgets('renders with custom color', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: FaceGuideOverlay(color: Colors.red)),
          ),
        );

        // Assert
        expect(find.byType(FaceGuideOverlay), findsOneWidget);
      });

      testWidgets('renders with custom strokeWidth', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: FaceGuideOverlay(strokeWidth: 4.0)),
          ),
        );

        // Assert
        expect(find.byType(FaceGuideOverlay), findsOneWidget);
      });

      testWidgets('renders with custom opacity', (WidgetTester tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: FaceGuideOverlay(opacity: 0.5)),
          ),
        );

        // Assert
        expect(find.byType(FaceGuideOverlay), findsOneWidget);
      });

      testWidgets('renders with all custom parameters', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FaceGuideOverlay(
                color: Colors.blue,
                strokeWidth: 3.0,
                opacity: 0.8,
              ),
            ),
          ),
        );

        // Assert
        expect(find.byType(FaceGuideOverlay), findsOneWidget);
      });
    });

    group('interaction', () {
      testWidgets('ignores pointer events (does not block taps)', (
        WidgetTester tester,
      ) async {
        // Arrange
        var buttonTapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Stack(
                children: [
                  // Button underneath the overlay
                  Center(
                    child: ElevatedButton(
                      onPressed: () => buttonTapped = true,
                      child: const Text('Tap me'),
                    ),
                  ),
                  // Overlay on top
                  const FaceGuideOverlay(),
                ],
              ),
            ),
          ),
        );

        // Act - tap through the overlay
        await tester.tap(find.text('Tap me'));
        await tester.pump();

        // Assert - button should receive the tap
        expect(buttonTapped, isTrue);
      });
    });

    group('default values', () {
      test('has correct default color', () {
        // Arrange & Act
        const overlay = FaceGuideOverlay();

        // Assert
        expect(overlay.color, equals(Colors.white));
      });

      test('has correct default strokeWidth', () {
        // Arrange & Act
        const overlay = FaceGuideOverlay();

        // Assert
        expect(overlay.strokeWidth, equals(2.0));
      });

      test('has correct default opacity', () {
        // Arrange & Act
        const overlay = FaceGuideOverlay();

        // Assert
        expect(overlay.opacity, equals(0.7));
      });
    });
  });
}

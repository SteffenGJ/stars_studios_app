import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stars_studios/components/content/content_card.dart';
import 'package:stars_studios/screens/content_screen.dart';

import '../mocks/mock_setup_functions.dart';

void main() {
  group("ContentScreen", () {
    testWidgets(
        "should show a loading indicator when the future is not complete",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ContentScreen(
          futureVideos: mockFetchVideos,
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("should show a list of content when the future is complete",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ContentScreen(
          futureVideos: mockFetchVideos,
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(ContentCard), findsWidgets);
    });
  });
}

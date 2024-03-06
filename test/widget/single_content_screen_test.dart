import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stars_studios/screens/single_content_screen.dart';

import '../mocks/mock_setup_functions.dart';

void main() {
  group("SingleContentScreen", () {
    testWidgets(
        "should show a loading indicator when the future is not complete",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SingleContentScreen(
            videoId: "videoId", title: "title", futureVideo: mockFetchVideo),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("should show the content when the future is complete",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SingleContentScreen(
            videoId: "videoId", title: "title", futureVideo: mockFetchVideo),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

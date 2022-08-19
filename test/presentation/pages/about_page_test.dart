import 'package:ditonton/presentation/pages/aboutpage/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _makeTestableWidget(Widget body) {
  return MaterialApp(
    home: body,
  );
}

void main() {
  testWidgets('About page should dispaly image and text',
          (WidgetTester tester) async {
        final image = find.byType(Image);
        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidget(AboutPage()));

        expect(image, findsOneWidget);
        expect(text, findsOneWidget);
      });

  testWidgets('About page should dispaly icon to back',
          (WidgetTester tester) async {
        final backButtonIcon = find.byIcon(Icons.arrow_back);

        await tester.pumpWidget(_makeTestableWidget(AboutPage()));

        expect(backButtonIcon, findsOneWidget);
      });
}

import 'package:about/about_page.dart';
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
    final text = find.text(
        'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.');

    await tester.pumpWidget(_makeTestableWidget(const AboutPage()));

    expect(text, findsOneWidget);
  });

  testWidgets('About page should dispaly icon to back',
      (WidgetTester tester) async {
    final backButtonIcon = find.byIcon(Icons.arrow_back);

    await tester.pumpWidget(_makeTestableWidget(const AboutPage()));

    expect(backButtonIcon, findsOneWidget);
  });
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshow/presentation/widgets/tvshow_card_list.dart';

import '../../dummydata/dummy_objects.dart';

void main() {
  group('Tv Show card Widget Test', () {
    Widget _makeTestableWidget() {
      return MaterialApp(
          home: Scaffold(
              body: TvShowCard(
        tvShow: testTvshow,
      )));
    }

    testWidgets('Testing if title tv show shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(RatingBarIndicator), findsOneWidget);
    });
  });
}

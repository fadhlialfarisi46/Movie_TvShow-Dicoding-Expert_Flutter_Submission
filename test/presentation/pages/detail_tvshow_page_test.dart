import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/presentation/pages/tvshowpages/detail_tvshow_page.dart';
import 'package:ditonton/presentation/provider/detail_tvshow_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tvshow_page_test.mocks.dart';

@GenerateMocks([DetailTvShowNotifier])
void main() {
  late MockDetailTvShowNotifier mockNotifier;

  setUp(() => mockNotifier = MockDetailTvShowNotifier());

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<DetailTvShowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Detail page should display circular progress when loading',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Loading);

        final circularProgressIndicator = find.byType(
            CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(circularProgressIndicator, findsOneWidget);
      });

  testWidgets(
      'Detail page should display text when error or empty',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error');

        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(text, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display add icon when tvshow not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
        when(mockNotifier.detailTvShow).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when detailTvShow is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
        when(mockNotifier.detailTvShow).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
        when(mockNotifier.detailTvShow).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
        when(mockNotifier.detailTvShow).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/moviepages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Detail page should display circular progress when loading',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loading);

        final circularProgressIndicator = find.byType(
            CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(circularProgressIndicator, findsOneWidget);
      });

  testWidgets(
      'Detail page should display text when error or empty',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error');

        final text = find.byType(Text);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(text, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}

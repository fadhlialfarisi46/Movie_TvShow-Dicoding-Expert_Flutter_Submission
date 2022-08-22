import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/tvshow.dart';

import '../../dummydata/dummy_objects.dart';

class DetailTvShowEventFake extends Fake implements DetailTvshowEvent {}

class DetailTvShowStateFake extends Fake implements DetailTvshowState {}

class MockDetailTvShowBloc
    extends MockBloc<DetailTvshowEvent, DetailTvshowState>
    implements DetailTvshowBloc {}

void main() {
  late MockDetailTvShowBloc mockDetailTvShowBloc;

  setUpAll(() {
    registerFallbackValue(DetailTvShowEventFake());
    registerFallbackValue(DetailTvShowStateFake());
  });

  setUp(() => mockDetailTvShowBloc = MockDetailTvShowBloc());

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailTvshowBloc>.value(
      value: mockDetailTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Detail page should display circular progress when loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvShowBloc.state).thenReturn(
        DetailTvshowState.initial()
            .copyWith(tvShowDetailState: RequestState.Loading));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvShowBloc.state)
        .thenReturn(DetailTvshowState.initial().copyWith(
      tvShowDetailState: RequestState.Loaded,
      tvShowDetail: testTvShowDetail,
      tvShowRecommendationsState: RequestState.Loading,
      tvShowRecommendations: <TvShow>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvShowBloc.state)
        .thenReturn(DetailTvshowState.initial().copyWith(
      tvShowDetailState: RequestState.Loaded,
      tvShowDetail: testTvShowDetail,
      tvShowRecommendationsState: RequestState.Loaded,
      tvShowRecommendations: <TvShow>[],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv Show is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvShowBloc.state)
        .thenReturn(DetailTvshowState.initial().copyWith(
      tvShowDetailState: RequestState.Loaded,
      tvShowDetail: testTvShowDetail,
      tvShowRecommendationsState: RequestState.Loaded,
      tvShowRecommendations: <TvShow>[],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockDetailTvShowBloc,
        Stream.fromIterable([
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
          ),
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: DetailTvshowState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockDetailTvShowBloc,
        Stream.fromIterable([
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
          ),
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: DetailTvshowState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockDetailTvShowBloc,
        Stream.fromIterable([
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
          ),
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Loaded,
            tvShowDetail: testTvShowDetail,
            tvShowRecommendationsState: RequestState.Loaded,
            tvShowRecommendations: <TvShow>[],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: DetailTvshowState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Detail Tv Show Page should display Error Text when No Internet Network (Error)',
      (WidgetTester tester) async {
    when(() => mockDetailTvShowBloc.state).thenReturn(
        DetailTvshowState.initial().copyWith(
            tvShowDetailState: RequestState.Error,
            message: 'Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(DetailTvShowPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}

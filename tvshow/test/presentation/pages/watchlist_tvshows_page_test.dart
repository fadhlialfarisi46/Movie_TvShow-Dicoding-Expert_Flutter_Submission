import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/tvshow.dart';

class WatchListTvShowsEventFake extends Fake implements WatchlistTvshowsEvent {}

class WatchListTvShowsStateFake extends Fake implements WatchlistTvshowsState {}

class MockWatchListTvShowsBloc
    extends MockBloc<WatchlistTvshowsEvent, WatchlistTvshowsState>
    implements WatchlistTvshowsBloc {}

void main() {
  late MockWatchListTvShowsBloc mockWatchListTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(WatchListTvShowsEventFake());
    registerFallbackValue(WatchListTvShowsStateFake());
  });

  setUp(() {
    mockWatchListTvShowsBloc = MockWatchListTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvshowsBloc>.value(
      value: mockWatchListTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockWatchListTvShowsBloc.state)
        .thenReturn(WatchlistTvshowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
            when(() => mockWatchListTvShowsBloc.state)
        .thenReturn(const WatchlistTvshowsHasData(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
            when(() => mockWatchListTvShowsBloc.state)
        .thenReturn(const WatchlistTvshowsError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
          (WidgetTester tester) async {
            when(() => mockWatchListTvShowsBloc.state)
        .thenReturn(const WatchlistTvshowsEmpty('You haven\'t added any yet'));

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}

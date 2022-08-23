import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/tvshow.dart';

class OnAirTvShowEventFake extends Fake implements OnairTvshowEvent {}

class OnAirTvShowStateFake extends Fake implements OnairTvshowState {}

class MockOnAirTvShowsBloc extends MockBloc<OnairTvshowEvent, OnairTvshowState>
    implements OnairTvshowBloc {}

void main() {
  late MockOnAirTvShowsBloc mockOnAirTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(OnAirTvShowEventFake());
    registerFallbackValue(OnAirTvShowStateFake());
  });

  setUp(() {
    mockOnAirTvShowsBloc = MockOnAirTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnairTvshowBloc>.value(
      value: mockOnAirTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockOnAirTvShowsBloc.state).thenReturn(OnairTvshowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const OnAirTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
        when(() => mockOnAirTvShowsBloc.state)
        .thenReturn(const OnairTvshowLoaded(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnAirTvShowPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
        when(() => mockOnAirTvShowsBloc.state)
        .thenReturn(const OnairTvshowError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const OnAirTvShowPage()));

    expect(textFinder, findsOneWidget);
  });
}

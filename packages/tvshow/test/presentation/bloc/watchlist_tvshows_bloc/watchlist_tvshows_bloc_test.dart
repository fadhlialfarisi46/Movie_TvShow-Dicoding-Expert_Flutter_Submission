import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../../../dummydata/dummy_objects.dart';
import 'watchlist_tvshows_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvshowsBloc watchlistTvshowsBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistTvshowsBloc = WatchlistTvshowsBloc(mockGetWatchlistTvShows);
  });

  group('Watchlist Tv Shows', () {
    test('Initial state should be empty', () {
      expect(watchlistTvshowsBloc.state, const WatchlistTvshowsEmpty(''));
    });

    blocTest<WatchlistTvshowsBloc, WatchlistTvshowsState>(
      'Should emit [WatchlistTvshowsLoading, WatchlistTvshowsHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvShows.execute())
            .thenAnswer((_) async => Right([testWatchlistTvShow]));
        return watchlistTvshowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvshowsEvent()),
      expect: () => [
        WatchlistTvshowsLoading(),
        WatchlistTvshowsHasData([testWatchlistTvShow]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );

    blocTest<WatchlistTvshowsBloc, WatchlistTvshowsState>(
      'Should emit [WatchlistTvshowsLoading, WatchlistTvshowsHasData[], WatchlistTvshowsEmpty] when data is empty',
      build: () {
        when(mockGetWatchlistTvShows.execute())
            .thenAnswer((_) async => const Right(<TvShow>[]));
        return watchlistTvshowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvshowsEvent()),
      expect: () => [
        WatchlistTvshowsLoading(),
        const WatchlistTvshowsHasData(<TvShow>[]),
        const WatchlistTvshowsEmpty('You haven\'t added any yet'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );

    blocTest<WatchlistTvshowsBloc, WatchlistTvshowsState>(
      'Should emit [WatchlistTvshowsLoading, WatchlistError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvshowsBloc;
      },
      act: (bloc) => bloc.add(WatchlistTvshowsEvent()),
      expect: () => [
        WatchlistTvshowsLoading(),
        const WatchlistTvshowsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );
  });
}

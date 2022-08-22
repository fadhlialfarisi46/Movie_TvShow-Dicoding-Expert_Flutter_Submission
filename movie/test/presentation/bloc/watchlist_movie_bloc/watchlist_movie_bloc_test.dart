import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummydata/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tMovies = <Movie>[testMovie];

  group('Watchlist Movies', () {
    test('Initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty(''));
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistMovieLoading, WatchlistMovieHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovies));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistMovieLoading, WatchlistMovieHasData[], WatchlistMovieEmpty] when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(<Movie>[]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(<Movie>[]),
        WatchlistMovieEmpty('You haven\'t added any yet'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistMovieLoading, WatchlistError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieEvent()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}

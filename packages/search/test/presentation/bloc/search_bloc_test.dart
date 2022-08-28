import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvshows.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late SearchTvShowsBloc searchTvShowsBloc;
  late MockSearchTvShows mockSearchTvShows;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    searchTvShowsBloc = SearchTvShowsBloc(mockSearchTvShows);
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('Search Movies', () {
    test('Initial state should be empty', () {
      expect(searchMoviesBloc.state, const SearchEmpty(''));
    });

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Right(<Movie>[]));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchHasData(<Movie>[]),
        const SearchEmpty('No results found'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchMoviesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  final tTvShowModel = TvShow(
      backdropPath: '/wiE9doxiLwq3WCGamDIOb2PqBqc.jpg',
      firstAirDate: DateTime.parse('2013-09-12'),
      genreIds: const [18, 80],
      id: 60574,
      name: 'Peaky Blinders',
      originCountry: const ["GB"],
      originalLanguage: 'en',
      originalName: 'Peaky Blinders',
      overview: 'A gangster family epic set in 1919 Birmingham, '
          'England and centered on a gang who sew razor blades in the peaks of their caps,'
          'and their fierce boss Tommy Shelby, '
          'who means to move up in the world.',
      popularity: 1274.819,
      posterPath: '/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg',
      voteAverage: 8.6,
      voteCount: 7080);
  final tTvShowList = <TvShow>[tTvShowModel];
  const tQueryTvShow = 'chucky';

  group('Search Tv Shows', () {
    test('Initial state should be empty', () {
      expect(searchTvShowsBloc.state, const SearchEmpty(''));
    });

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Right(tTvShowList));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => const Right(<TvShow>[]));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchHasData(<TvShow>[]),
        const SearchEmpty('No results found'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );

    blocTest<SearchTvShowsBloc, SearchState>(
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvShowsBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
  });
}

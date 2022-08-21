import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvshows.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';

import 'movie_search_notifier_test.mocks.dart';


@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late MovieSearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    provider = MovieSearchNotifier(
        searchMovies: mockSearchMovies, searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
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
  final tEmptyMovieList = <Movie>[];
  const tQuery = 'spiderman';
  const tEmptyQuery = '';
  const tJunkQuery = 'cmqencewuncuew';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
            () async {
          // arrange
          when(mockSearchMovies.execute(tQuery))
              .thenAnswer((_) async => Right(tMovieList));
          // act
          await provider.fetchMovieSearch(tQuery);
          // assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tMovieList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should return empty when query is empty', () async {
      // arrange
      when(mockSearchMovies.execute(tEmptyQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(tEmptyQuery);
      // assert
      expect(provider.state, RequestState.Empty);
      expect(provider.message, 'Try input some keyword');
    });

    test('should return empty when data is empty', () async {
      // arrange
      when(mockSearchMovies.execute(tJunkQuery))
          .thenAnswer((_) async => Right(tEmptyMovieList));
      // act
      await provider.fetchMovieSearch(tJunkQuery);
      // assert
      expect(provider.state, RequestState.Empty);
      expect(provider.message, 'Go find another keyword');
    });
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
  final tEmptyTvShowList = <TvShow>[];
  const tQueryTvShow = 'Peaky Blinders';

  group('search tvshows', () {
    test('Tv Show should change state to loading when usecase is called',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowSearch(tQueryTvShow);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test(
        'Tv Show should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tQueryTvShow);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchTvShowsResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('Tv Show should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQueryTvShow))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQueryTvShow);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('Tv Show should return empty when query is empty', () async {
      // arrange
      when(mockSearchTvShows.execute(tEmptyQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tEmptyQuery);
      // assert
      expect(provider.state, RequestState.Empty);
      expect(provider.message, 'Try input some keyword');
    });

    test('Tv Show should return empty when data is empty', () async {
      // arrange
      when(mockSearchTvShows.execute(tJunkQuery))
          .thenAnswer((_) async => Right(tEmptyTvShowList));
      // act
      await provider.fetchTvShowSearch(tJunkQuery);
      // assert
      expect(provider.state, RequestState.Empty);
      expect(provider.message, 'Go find another keyword');
    });
  });
}

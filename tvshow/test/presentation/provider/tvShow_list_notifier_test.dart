import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/provider/tvshow_list_notifier.dart';

import 'tvShow_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirTvShows, GetPopularTvShows, GetTopRatedTvShows])
void main() {
  late TvShowListNotifier provider;
  late MockGetOnAirTvShows mockGetOnAirTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTvShows = MockGetOnAirTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    provider = TvShowListNotifier(
      getOnAirTvShows: mockGetOnAirTvShows,
      getPopularTvShows: mockGetPopularTvShows,
      getTopRatedTvShows: mockGetTopRatedTvShows,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: DateTime.parse('2022-14-08'),
    originalLanguage: 'en',
    name: 'name',
    originCountry: ['en'],
    originalName: 'originalName',
  );
  final tTvShowList = <TvShow>[tTvShow];

  group('now playing tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.onAirTvShowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnAirTvShows();
      // assert
      verify(mockGetOnAirTvShows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirTvShowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirTvShowsState, RequestState.Loaded);
      expect(provider.onAirTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTvShows();
      // assert
      expect(provider.onAirTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvshows data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));
          // act
          await provider.fetchPopularTvShows();
          // assert
          expect(provider.popularTvShowsState, RequestState.Loaded);
          expect(provider.popularTvShows, tTvShowList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('should change tvshows data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));
          // act
          await provider.fetchTopRatedTvShows();
          // assert
          expect(provider.topRatedTvShowsState, RequestState.Loaded);
          expect(provider.topRatedTvShows, tTvShowList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

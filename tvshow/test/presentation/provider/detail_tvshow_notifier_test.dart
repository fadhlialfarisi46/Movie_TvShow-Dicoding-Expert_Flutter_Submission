import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/provider/detail_tvshow_notifier.dart';

import '../../dummydata/dummy_objects.dart';
import 'detail_tvshow_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTvShow,
  GetRecommendationTvShow,
  GetWatchListByIdTvShow,
  InsertWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late DetailTvShowNotifier provider;
  late MockGetDetailTvShow mockGetDetailTvShow;
  late MockGetRecommendationTvShow mockGetRecommendationTvShow;
  late MockGetWatchListByIdTvShow mockGetWatchListByIdTvShow;
  late MockInsertWatchlistTvShow mockInsertWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlistTvShow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    mockInsertWatchlistTvShow = MockInsertWatchlistTvShow();
    mockGetWatchListByIdTvShow = MockGetWatchListByIdTvShow();
    mockGetDetailTvShow = MockGetDetailTvShow();
    mockGetRecommendationTvShow = MockGetRecommendationTvShow();
    provider = DetailTvShowNotifier(
        getDetailTvShow: mockGetDetailTvShow,
        getRecommendationTvShow: mockGetRecommendationTvShow,
        getWatchListByIdTvShow: mockGetWatchListByIdTvShow,
        insertWatchlistTvShow: mockInsertWatchlistTvShow,
        removeWatchlistTvShow: mockRemoveWatchlistTvShow)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2022-14-08'),
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowS = <TvShow>[tTvShow];

  void arrangeUseCase() {
    when(mockGetDetailTvShow.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetRecommendationTvShow.execute(tId))
        .thenAnswer((_) async => Right(tTvShowS));
  }

  group('Get TvShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUseCase();
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      verify(mockGetDetailTvShow.execute(tId));
      verify(mockGetRecommendationTvShow.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUseCase();
      // act
      provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TvShow when data is gotten successfully', () async {
      // arrange
      arrangeUseCase();
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.detailTvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation TvShows when data is gotten successfully',
        () async {
      // arrange
      arrangeUseCase();
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShowS);
    });
  });

  group('Get TvShow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUseCase();
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      verify(mockGetRecommendationTvShow.execute(tId));
      expect(provider.tvShowRecommendations, tTvShowS);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUseCase();
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShowS);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetDetailTvShow.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetRecommendationTvShow.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListByIdTvShow.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockInsertWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListByIdTvShow.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockInsertWatchlistTvShow.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListByIdTvShow.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockInsertWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListByIdTvShow.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetWatchListByIdTvShow.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockInsertWatchlistTvShow.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListByIdTvShow.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetDetailTvShow.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecommendationTvShow.execute(tId))
          .thenAnswer((_) async => Right(tTvShowS));
      // act
      await provider.fetchDetailTvShow(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

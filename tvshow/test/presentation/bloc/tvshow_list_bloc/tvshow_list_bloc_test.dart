import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import 'tvshow_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnAirTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
])
void main() {
  late PopularTvshowListBloc popularTvshowListBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late OnAirTvshowListBloc onAirTvshowListBloc;
  late MockGetOnAirTvShows mockGetOnAirTvShows;
  late TopRatedTvshowListBloc topRatedTvshowListBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvshowListBloc = TopRatedTvshowListBloc(mockGetTopRatedTvShows);
    mockGetOnAirTvShows = MockGetOnAirTvShows();
    onAirTvshowListBloc = OnAirTvshowListBloc(mockGetOnAirTvShows);
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvshowListBloc = PopularTvshowListBloc(mockGetPopularTvShows);
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

  group('On Air Today Tv Show list', () {
    test('Initial state should be empty', () {
      expect(onAirTvshowListBloc.state, TvshowListEmpty());
    });

    blocTest<OnAirTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetOnAirTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return onAirTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTvShows.execute());
      },
    );

    blocTest<OnAirTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetOnAirTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return onAirTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetOnAirTvShows.execute());
      },
    );
  });

  group('Popular Tv Show list', () {
    test('Initial state should be empty', () {
      expect(popularTvshowListBloc.state, TvshowListEmpty());
    });

    blocTest<PopularTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return popularTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<PopularTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });

  group('Top Rated Tv Show list', () {
    test('Initial state should be empty', () {
      expect(topRatedTvshowListBloc.state, TvshowListEmpty());
    });

    blocTest<TopRatedTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return topRatedTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );

    blocTest<TopRatedTvshowListBloc, TvshowListState>(
      'Should emit [TvshowListLoading, TvShowListError] when get Failure',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvshowListBloc;
      },
      act: (bloc) => bloc.add(TvshowEvent()),
      expect: () => [
        TvshowListLoading(),
        TvshowListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
  });
}

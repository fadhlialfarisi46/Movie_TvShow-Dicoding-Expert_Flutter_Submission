import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../tvshow_list_bloc/tvshow_list_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late MockGetPopularTvShows mockGetPopularTvShows;
  late PopularTvshowBloc popularTvshowBloc;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvshowBloc = PopularTvshowBloc(mockGetPopularTvShows);
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

  group('Popular Tv Shows', () {
    test('Initial state should be empty', () {
      expect(popularTvshowBloc.state, PopularTvShowsEmpty());
    });

    blocTest<PopularTvshowBloc, PopularTvShowsState>(
      'Should emit [PopularTvShowsLoading, PopularTvshowLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return popularTvshowBloc;
      },
      act: (bloc) => bloc.add(PopularTvshowEvent()),
      expect: () =>
      [
        PopularTvShowsLoading(),
        PopularTvShowsLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<PopularTvshowBloc, PopularTvShowsState>(
      'Should emit [PopularTvShowsLoading, PopularTvShowsError] when get Failure',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvshowBloc;
      },
      act: (bloc) => bloc.add(PopularTvshowEvent()),
      expect: () =>
      [
        PopularTvShowsLoading(),
        PopularTvShowsError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });
}

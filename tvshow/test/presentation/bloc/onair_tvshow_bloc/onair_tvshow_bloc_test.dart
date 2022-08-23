import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/tvshow.dart';

import '../tvshow_list_bloc/tvshow_list_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTvShows])
void main() {
  late MockGetOnAirTvShows mockGetOnAirTvShows;
  late OnairTvshowBloc onairTvshowBloc;

  setUp(() {
    mockGetOnAirTvShows = MockGetOnAirTvShows();
    onairTvshowBloc = OnairTvshowBloc(mockGetOnAirTvShows);
  });

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: DateTime.parse('2022-14-08'),
    originalLanguage: 'en',
    name: 'name',
    originCountry: const ['en'],
    originalName: 'originalName',
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('Airing Today Tv Shows', () {
    test('Initial state should be empty', () {
      expect(onairTvshowBloc.state, OnairTvshowEmpty());
    });

    blocTest<OnairTvshowBloc, OnairTvshowState>(
      'Should emit [OnairTvshowLoading, OnairTvshowLoaded] when data is gotten successfully',
      build: () {
        when(mockGetOnAirTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return onairTvshowBloc;
      },
      act: (bloc) => bloc.add(OnairTvshowEvent()),
      expect: () => [
        OnairTvshowLoading(),
        OnairTvshowLoaded(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTvShows.execute());
      },
    );

    blocTest<OnairTvshowBloc, OnairTvshowState>(
      'Should emit [OnairTvshowLoading, AiringTodayTvShowsError] when get Failure',
      build: () {
        when(mockGetOnAirTvShows.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return onairTvshowBloc;
      },
      act: (bloc) => bloc.add(OnairTvshowEvent()),
      expect: () =>
      [
        OnairTvshowLoading(),
        const OnairTvshowError('Failed'),
      ],
      verify: (_) {
        verify(mockGetOnAirTvShows.execute());
      },
    );
  });
}

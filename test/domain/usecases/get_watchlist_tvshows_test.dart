import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistTvShows(mockMovieRepository);
  });

  test('should get list of tvshows from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvshowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvshowList));
  });
}

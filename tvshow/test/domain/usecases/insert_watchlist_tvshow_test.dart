import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';

import '../../dummydata/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late InsertWatchlistTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = InsertWatchlistTvShow(mockMovieRepository);
  });

  test('should save tvshow to the repository', () async {
    // arrange
    when(mockMovieRepository.insertWatchListTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockMovieRepository.insertWatchListTvShow(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}

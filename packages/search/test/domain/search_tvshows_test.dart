import 'package:core/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvshows.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTvShows(mockMovieRepository);
  });

  final tTvShows = <TvShow>[];
  const tQuery = 'Spiderman';

  test('should get list of tvshows from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShows));
  });
}

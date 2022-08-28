import 'package:core/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetRecommendationTvShow(mockMovieRepository);
  });

  const tId = 1;
  final tTvShow = <TvShow>[];

  test('should get list of tvshow recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getRecommendationTvShow(tId))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvShow));
  });
}

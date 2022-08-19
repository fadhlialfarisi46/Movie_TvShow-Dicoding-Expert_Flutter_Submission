import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_detail_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailTvShow usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetDetailTvShow(mockMovieRepository);
  });

  final tId = 1;

  test('should get tvshow detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getDetailTvShow(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvShowDetail));
  });
}

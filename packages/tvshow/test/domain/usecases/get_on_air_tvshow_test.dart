import 'package:core/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTvShows usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = GetOnAirTvShows(mockMovieRpository);
  });

  final tTvshow = <TvShow>[];

  group('GetOnAirTvShows Tests', () {
    group('execute', () {
      test(
          'should get list of tvshows from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getOnAirTvShows())
            .thenAnswer((_) async => Right(tTvshow));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvshow));
      });
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetRecommendationTvShow {
  final MovieRepository repository;

  GetRecommendationTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getRecommendationTvShow(id);
  }
}

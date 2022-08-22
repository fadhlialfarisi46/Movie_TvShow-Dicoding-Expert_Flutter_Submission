part of 'usecases.dart';

class GetRecommendationTvShow {
  final MovieRepository repository;

  GetRecommendationTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getRecommendationTvShow(id);
  }
}

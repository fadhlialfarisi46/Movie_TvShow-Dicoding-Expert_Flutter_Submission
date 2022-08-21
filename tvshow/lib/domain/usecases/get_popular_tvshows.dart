part of 'usecases.dart';

class GetPopularTvShows {
  final MovieRepository repository;

  GetPopularTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShows();
  }
}

part of 'usecases.dart';

class GetTopRatedTvShows {
  final MovieRepository repository;

  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShows();
  }
}

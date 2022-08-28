part of 'usecases.dart';

class GetOnAirTvShows {
  final MovieRepository repository;

  GetOnAirTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnAirTvShows();
  }
}

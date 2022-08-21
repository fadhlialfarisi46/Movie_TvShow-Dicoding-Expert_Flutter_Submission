part of 'usecases.dart';

class GetWatchlistTvShows {
  final MovieRepository _repository;

  GetWatchlistTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchlistTvShows();
  }
}
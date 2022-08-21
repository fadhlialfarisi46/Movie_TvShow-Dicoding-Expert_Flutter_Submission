part of 'usecases.dart';

class RemoveWatchlistTvShow {
  final MovieRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.removeWatchlistTvShow(tvShowDetail);
  }
}
part of 'usecases.dart';

class InsertWatchlistTvShow {
  final MovieRepository repository;

  InsertWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.insertWatchListTvShow(tvShowDetail);
  }
}
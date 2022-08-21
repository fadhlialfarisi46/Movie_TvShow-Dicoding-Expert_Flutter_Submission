part of 'usecases.dart';

class GetDetailTvShow {
  final MovieRepository repository;

  GetDetailTvShow(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getDetailTvShow(id);
  }
}

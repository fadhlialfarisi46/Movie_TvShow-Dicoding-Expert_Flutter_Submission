part of 'usecases.dart';

class GetWatchListByIdTvShow {
  final MovieRepository repository;

  GetWatchListByIdTvShow(this.repository);

  Future<bool> execute(int id) async {
    return repository.getTvShowById(id);
  }
}

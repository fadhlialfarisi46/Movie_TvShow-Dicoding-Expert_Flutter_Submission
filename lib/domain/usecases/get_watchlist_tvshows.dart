import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistTvShows {
  final MovieRepository _repository;

  GetWatchlistTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getWatchlistTvShows();
  }
}

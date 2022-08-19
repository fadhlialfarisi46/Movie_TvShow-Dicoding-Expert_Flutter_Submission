import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tvshow_detail.dart';
import '../repositories/movie_repository.dart';

class InsertWatchlistTvShow {
  final MovieRepository repository;

  InsertWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.insertWatchListTvShow(tvShowDetail);
  }
}

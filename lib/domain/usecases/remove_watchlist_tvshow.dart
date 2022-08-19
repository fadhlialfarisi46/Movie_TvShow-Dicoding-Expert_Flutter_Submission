import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class RemoveWatchlistTvShow {
  final MovieRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShowDetail) {
    return repository.removeWatchlistTvShow(tvShowDetail);
  }
}

import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tvshow.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedTvShows {
  final MovieRepository repository;

  GetTopRatedTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getTopRatedTvShows();
  }
}

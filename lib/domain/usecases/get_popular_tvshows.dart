import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetPopularTvShows {
  final MovieRepository repository;

  GetPopularTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getPopularTvShows();
  }
}

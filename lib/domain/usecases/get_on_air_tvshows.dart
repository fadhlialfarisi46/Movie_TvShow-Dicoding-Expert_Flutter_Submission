import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetOnAirTvShows {
  final MovieRepository repository;

  GetOnAirTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnAirTvShows();
  }
}

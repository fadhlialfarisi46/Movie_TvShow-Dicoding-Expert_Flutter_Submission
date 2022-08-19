import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetDetailTvShow {
  final MovieRepository repository;

  GetDetailTvShow(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getDetailTvShow(id);
  }
}

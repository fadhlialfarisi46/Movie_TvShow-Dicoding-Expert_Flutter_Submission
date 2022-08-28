import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/entities.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);

  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);

  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);

  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);

  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<Movie>>> getWatchlistMovies();

  Future<Either<Failure, String>> insertWatchListTvShow(
      TvShowDetail tvShowDetail);

  Future<Either<Failure, String>> removeWatchlistTvShow(
      TvShowDetail tvShowDetail);

  Future<bool> getTvShowById(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();

  Future<Either<Failure, List<TvShow>>> getOnAirTvShows();

  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  Future<Either<Failure, TvShowDetail>> getDetailTvShow(int id);

  Future<Either<Failure, List<TvShow>>> getRecommendationTvShow(int id);
}

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tvshow/tvshow.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
        () =>
        MovieListNotifier(
          getNowPlayingMovies: locator(),
          getPopularMovies: locator(),
          getTopRatedMovies: locator(),
        ),
  );
  locator.registerFactory(
    () => TvShowListNotifier(
      getOnAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () =>
        MovieSearchNotifier(searchMovies: locator(), searchTvShows: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnAirTvShowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvShowNotifier(
      getDetailTvShow: locator(),
      getRecommendationTvShow: locator(),
      getWatchListByIdTvShow: locator(),
      removeWatchlistTvShow: locator(),
      insertWatchlistTvShow: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowNotifier(
      getWatchlistTvShows: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetOnAirTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetDetailTvShow(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchListByIdTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => InsertWatchlistTvShow(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}

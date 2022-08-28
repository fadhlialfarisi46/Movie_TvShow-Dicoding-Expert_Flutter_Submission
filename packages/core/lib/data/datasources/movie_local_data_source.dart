import '../../utils/exception.dart';
import '../models/models.dart';
import 'db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);

  Future<String> removeWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies();

  Future<String> insertWatchListTvShow(TvShowTable tvShowTable);

  Future<String> removeWatchlistTvShow(TvShowTable tvShowTable);

  Future<TvShowTable?> getTvShowById(int id);

  Future<List<TvShowTable>> getWatchlistTvShows();

  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedNowPlayingMovies();

  Future<void> cachePopularMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedPopularMovies();

  Future<void> cacheTopRatedMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCachedTopRatedMovies();

  Future<void> cacheOnAirTvShows(List<TvShowTable> tvShows);

  Future<List<TvShowTable>> getCachedOnAirTvShows();

  Future<void> cachePopularTvShows(List<TvShowTable> tvShows);

  Future<List<TvShowTable>> getCachedPopularTvShows();

  Future<void> cacheTopRatedTvShows(List<TvShowTable> tvShows);

  Future<List<TvShowTable>> getCachedTopRatedTvShows();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchListTvShow(TvShowTable tvShowTable) async {
    try {
      await databaseHelper.insertWatchListTvShow(tvShowTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvShow(TvShowTable tvShowTable) async {
    try {
      await databaseHelper.removeWatchlistTvShow(tvShowTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCacheMovies('now playing');
    await databaseHelper.insertCacheTransactionMovies(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((e) => MovieTable.fromMap(e)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCacheMovies('popular');
    await databaseHelper.insertCacheTransactionMovies(movies, 'popular');
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    final result = await databaseHelper.getCacheMovies('popular');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCacheMovies('top rated');
    await databaseHelper.insertCacheTransactionMovies(movies, 'top rated');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    final result = await databaseHelper.getCacheMovies('top rated');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }

  @override
  Future<void> cacheOnAirTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('on air');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'on air');
  }

  @override
  Future<void> cachePopularTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('popular');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'popular');
  }

  @override
  Future<void> cacheTopRatedTvShows(List<TvShowTable> tvShows) async {
    await databaseHelper.clearCacheTvShows('top rated');
    await databaseHelper.insertCacheTransactionTvShows(tvShows, 'top rated');
  }

  @override
  Future<List<TvShowTable>> getCachedOnAirTvShows() async {
    final result = await databaseHelper.getCacheTvShows('on air');
    if (result.isNotEmpty) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }

  @override
  Future<List<TvShowTable>> getCachedPopularTvShows() async {
    final result = await databaseHelper.getCacheTvShows('popular');
    if (result.isNotEmpty) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }

  @override
  Future<List<TvShowTable>> getCachedTopRatedTvShows() async {
    final result = await databaseHelper.getCacheTvShows('top rated');
    if (result.isNotEmpty) {
      return result.map((data) => TvShowTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data ");
    }
  }
}

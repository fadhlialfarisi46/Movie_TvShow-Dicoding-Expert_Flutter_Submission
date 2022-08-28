import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'movie_watchlist';
  static const String _tblTvShowWatchlist = 'tvshow_watchlist';
  static const String _tblCacheMovie = 'cache_movie';
  static const String _tblCacheTvShow = 'cache_tvshow';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblTvShowWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        voteAverage REAL
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheMovie (
        id INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheTvShow (
        id INTEGER,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        voteAverage REAL,
        category TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<int> insertWatchListTvShow(TvShowTable tvShowTable) async {
    final db = await database;
    return await db!.insert(_tblTvShowWatchlist, tvShowTable.toJson());
  }

  Future<int> removeWatchlistTvShow(TvShowTable tvShowTable) async {
    final db = await database;
    return await db!.delete(
      _tblTvShowWatchlist,
      where: 'id = ?',
      whereArgs: [tvShowTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvShowWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblTvShowWatchlist);

    return results;
  }

  Future<void> insertCacheTransactionMovies(
      List<MovieTable> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCacheMovie, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCacheMovies(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<void> insertCacheTransactionTvShows(
      List<TvShowTable> tvShows, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tvShow in tvShows) {
        final tvShowsJson = tvShow.toJson();
        tvShowsJson['category'] = category;
        txn.insert(_tblCacheTvShow, tvShowsJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTvShows(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheTvShow,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCacheTvShows(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTvShow,
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}

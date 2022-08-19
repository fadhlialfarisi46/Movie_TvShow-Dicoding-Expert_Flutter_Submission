import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvshows.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  MovieSearchNotifier(
      {required this.searchMovies, required this.searchTvShows});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _searchResult = [];

  List<Movie> get searchResult => _searchResult;

  List<TvShow> _searchTvShowsResult = [];

  List<TvShow> get searchTvShowsResult => _searchTvShowsResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    if (query.isEmpty) {
      _state = RequestState.Empty;
      _message = 'Try input some keyword';
      notifyListeners();
    } else {
      final result = await searchMovies.execute(query);
      result.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          if (data.isEmpty) {
            _message = 'Go find another keyword';
            _state = RequestState.Empty;
          } else {
            _searchResult = data;
            _state = RequestState.Loaded;
          }
          notifyListeners();
        },
      );
    }
  }

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    if (query.isEmpty) {
      _state = RequestState.Empty;
      _message = 'Try input some keyword';
      notifyListeners();
    } else {
      final result = await searchTvShows.execute(query);
      result.fold(
        (failure) {
          _message = failure.message;
          _state = RequestState.Error;
          notifyListeners();
        },
        (data) {
          if (data.isEmpty) {
            _message = 'Go find another keyword';
            _state = RequestState.Empty;
          } else {
            _searchTvShowsResult = data;
            _state = RequestState.Loaded;
          }
          notifyListeners();
        },
      );
    }
  }
}

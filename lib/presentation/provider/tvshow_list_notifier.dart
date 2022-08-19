import 'package:ditonton/domain/usecases/get_top_rated_tvshows.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tvshow.dart';
import '../../domain/usecases/get_on_air_tvshows.dart';
import '../../domain/usecases/get_popular_tvshows.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _onAirTvShows = <TvShow>[];

  List<TvShow> get onAirTvShows => _onAirTvShows;

  RequestState _onAirTvShowsState = RequestState.Empty;

  RequestState get onAirTvShowsState => _onAirTvShowsState;

  var _popularTvShows = <TvShow>[];

  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;

  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];

  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;

  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';

  String get message => _message;

  TvShowListNotifier(
      {required this.getOnAirTvShows,
      required this.getPopularTvShows,
      required this.getTopRatedTvShows});

  final GetOnAirTvShows getOnAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchOnAirTvShows() async {
    _onAirTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvShows.execute();
    result.fold(
      (failure) {
        _onAirTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _onAirTvShowsState = RequestState.Loaded;
        _onAirTvShows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = moviesData;
        notifyListeners();
      },
    );
  }
}

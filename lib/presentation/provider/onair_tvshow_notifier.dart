import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/usecases/get_on_air_tvshows.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';

class OnAirTvShowsNotifier extends ChangeNotifier {
  final GetOnAirTvShows getOnAirTvShows;

  OnAirTvShowsNotifier(this.getOnAirTvShows);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _tvShows = [];

  List<TvShow> get tvShows => _tvShows;

  String _message = '';

  String get message => _message;

  Future<void> fetchOnAirTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

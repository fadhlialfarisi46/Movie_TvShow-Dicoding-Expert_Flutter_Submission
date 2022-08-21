import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/usecases.dart';

class PopularTvShowsNotifier extends ChangeNotifier {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowsNotifier(this.getPopularTvShows);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _tvShows = [];

  List<TvShow> get tvShows => _tvShows;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

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

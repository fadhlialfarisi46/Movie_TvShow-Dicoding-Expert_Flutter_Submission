import 'package:ditonton/domain/entities/tvshow.dart';
import 'package:ditonton/domain/entities/tvshow_detail.dart';
import 'package:ditonton/domain/usecases/get_detail_tvshow.dart';
import 'package:ditonton/domain/usecases/get_recommendation_tvshow.dart';
import 'package:ditonton/domain/usecases/get_watchlist_byid_tvshow.dart';
import 'package:ditonton/domain/usecases/insert_watchlist_tvshow.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';

class DetailTvShowNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTvShow getDetailTvShow;
  final GetRecommendationTvShow getRecommendationTvShow;
  final GetWatchListByIdTvShow getWatchListByIdTvShow;
  final InsertWatchlistTvShow insertWatchlistTvShow;
  final RemoveWatchlistTvShow removeWatchlistTvShow;

  DetailTvShowNotifier({
    required this.getDetailTvShow,
    required this.getRecommendationTvShow,
    required this.getWatchListByIdTvShow,
    required this.insertWatchlistTvShow,
    required this.removeWatchlistTvShow,
  });

  late TvShowDetail _detailTvShow;

  TvShowDetail get detailTvShow => _detailTvShow;

  RequestState _tvShowState = RequestState.Empty;

  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];

  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchDetailTvShow(int id) async {
    _tvShowState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getDetailTvShow.execute(id);
    final recommendationResult = await getRecommendationTvShow.execute(id);

    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.Loading;
        _detailTvShow = tvShow;
        notifyListeners();
        recommendationResult.fold((failure) {
          _recommendationState = RequestState.Error;
          _message = failure.message;
        }, (tvShows) {
          _recommendationState = RequestState.Loaded;
          _tvShowRecommendations = tvShows;
        });
        _tvShowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvShowDetail) async {
    final result = await insertWatchlistTvShow.execute(tvShowDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShowDetail.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShowDetail) async {
    final result = await removeWatchlistTvShow.execute(tvShowDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShowDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListByIdTvShow.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}

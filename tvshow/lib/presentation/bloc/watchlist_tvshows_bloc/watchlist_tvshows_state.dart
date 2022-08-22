part of 'watchlist_tvshows_bloc.dart';

abstract class WatchlistTvshowsState extends Equatable {
  const WatchlistTvshowsState();

  @override
  List<Object> get props => [];
}

class WatchlistTvshowsEmpty extends WatchlistTvshowsState {
  final String message;

  const WatchlistTvshowsEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvshowsLoading extends WatchlistTvshowsState {}

class WatchlistTvshowsError extends WatchlistTvshowsState {
  final String message;

  const WatchlistTvshowsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvshowsHasData<T> extends WatchlistTvshowsState {
  final List<T> watchlistResult;

  const WatchlistTvshowsHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

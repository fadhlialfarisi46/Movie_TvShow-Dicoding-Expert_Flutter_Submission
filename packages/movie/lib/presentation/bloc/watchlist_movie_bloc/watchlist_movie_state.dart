part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {
  final String message;

  const WatchlistMovieEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData<T> extends WatchlistMovieState {
  final List<T> watchlistResult;

  const WatchlistMovieHasData(this.watchlistResult);

  @override
  List<Object> get props => [watchlistResult];
}

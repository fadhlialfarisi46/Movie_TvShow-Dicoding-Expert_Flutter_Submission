import 'package:core/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecase/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchListMovies;

  WatchlistMovieBloc(this._getWatchListMovies)
      : super(const WatchlistMovieEmpty('')) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchListMovies.execute();
      result.fold((failure) => emit(WatchlistMovieError(failure.message)),
          (moviesData) {
        emit(WatchlistMovieHasData<Movie>(moviesData));
        if (moviesData.isEmpty) {
          emit(const WatchlistMovieEmpty('You haven\'t added any yet'));
        }
      });
    });
  }
}

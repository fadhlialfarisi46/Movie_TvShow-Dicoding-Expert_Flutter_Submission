import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/usecases.dart';

part 'watchlist_tvshows_event.dart';

part 'watchlist_tvshows_state.dart';

class WatchlistTvshowsBloc
    extends Bloc<WatchlistTvshowsEvent, WatchlistTvshowsState> {
  final GetWatchlistTvShows getWatchListTvShows;

  WatchlistTvshowsBloc(this.getWatchListTvShows)
      : super(const WatchlistTvshowsEmpty('')) {
    on<WatchlistTvshowsEvent>((event, emit) async {
      emit(WatchlistTvshowsLoading());
      final result = await getWatchListTvShows.execute();
      result.fold((l) => emit(WatchlistTvshowsError(l.message)), (r) {
        emit(WatchlistTvshowsHasData(r));
        if (r.isEmpty) {
          emit(const WatchlistTvshowsEmpty('You haven\'t added any yet'));
        }
      });
    });
  }
}

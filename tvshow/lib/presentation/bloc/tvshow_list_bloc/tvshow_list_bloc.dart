import 'package:core/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

import '../../../domain/usecases/usecases.dart';

part 'tvshow_list_event.dart';

part 'tvshow_list_state.dart';

class OnAirTvshowListBloc extends Bloc<TvshowEvent, TvshowListState> {
  final GetOnAirTvShows getOnAirTvShow;

  OnAirTvshowListBloc(this.getOnAirTvShow) : super(TvshowListEmpty()) {
    on<TvshowEvent>((event, emit) async {
      emit(TvshowListLoading());
      final result = await getOnAirTvShow.execute();
      result.fold((l) => emit(TvshowListError(l.message)),
          (r) => emit(TvshowListLoaded(r)));
    });
  }
}

class PopularTvshowListBloc extends Bloc<TvshowEvent, TvshowListState> {
  final GetPopularTvShows getPopularTvShows;

  PopularTvshowListBloc(this.getPopularTvShows) : super(TvshowListEmpty()) {
    on<TvshowEvent>((event, emit) async {
      emit(TvshowListLoading());
      final result = await getPopularTvShows.execute();
      result.fold((l) => emit(TvshowListError(l.message)),
          (r) => emit(TvshowListLoaded(r)));
    });
  }
}

class TopRatedTvshowListBloc extends Bloc<TvshowEvent, TvshowListState> {
  final GetTopRatedTvShows getTopRatedTvShows;

  TopRatedTvshowListBloc(this.getTopRatedTvShows) : super(TvshowListEmpty()) {
    on<TvshowEvent>((event, emit) async {
      emit(TvshowListLoading());
      final result = await getTopRatedTvShows.execute();
      result.fold((l) => emit(TvshowListError(l.message)),
          (r) => emit(TvshowListLoaded(r)));
    });
  }
}

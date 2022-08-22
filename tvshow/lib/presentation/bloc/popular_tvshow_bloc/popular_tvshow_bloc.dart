import 'package:core/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/usecases.dart';

part 'popular_tvshow_event.dart';

part 'popular_tvshow_state.dart';

class PopularTvshowBloc extends Bloc<PopularTvshowEvent, PopularTvShowsState> {
  final GetPopularTvShows getPopularTvShows;

  PopularTvshowBloc(this.getPopularTvShows) : super(PopularTvShowsEmpty()) {
    on<PopularTvshowEvent>((event, emit) async {
      emit(PopularTvShowsLoading());
      final result = await getPopularTvShows.execute();
      result.fold(
        (l) => emit(PopularTvShowsError(l.message)),
        (r) => emit(PopularTvShowsLoaded(r)),
      );
    });
  }
}

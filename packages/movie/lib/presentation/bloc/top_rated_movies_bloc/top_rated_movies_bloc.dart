import 'package:core/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<TopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (l) => emit(TopRatedMoviesError(l.message)),
        (r) => emit(TopRatedMoviesLoaded(r)),
      );
    });
  }
}

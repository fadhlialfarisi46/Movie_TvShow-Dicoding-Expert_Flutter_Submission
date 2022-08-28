import 'package:core/domain/entities/entities.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

part 'detail_tvshow_event.dart';

part 'detail_tvshow_state.dart';

class DetailTvshowBloc extends Bloc<DetailTvshowEvent, DetailTvshowState> {
  final GetDetailTvShow getDetailTvShow;
  final GetRecommendationTvShow getRecommendationTvShow;
  final GetWatchListByIdTvShow getWatchListByIdTvShow;
  final InsertWatchlistTvShow insertWatchlistTvShow;
  final RemoveWatchlistTvShow removeWatchlistTvShow;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  DetailTvshowBloc({
    required this.getDetailTvShow,
    required this.getRecommendationTvShow,
    required this.getWatchListByIdTvShow,
    required this.insertWatchlistTvShow,
    required this.removeWatchlistTvShow,
  }) : super(DetailTvshowState.initial()) {
    on<FetchDetailTvShow>((event, emit) async {
      emit(state.copyWith(tvShowDetailState: RequestState.Loading));

      final detailResult = await getDetailTvShow.execute(event.id);
      final recommendationResult =
          await getRecommendationTvShow.execute(event.id);

      detailResult.fold(
        (l) => emit(state.copyWith(
          tvShowDetailState: RequestState.Error,
          message: l.message,
        )),
        (tvshow) => {
          emit(state.copyWith(
            tvShowRecommendationsState: RequestState.Loading,
            tvShowDetail: tvshow,
            tvShowDetailState: RequestState.Loaded,
          )),
          recommendationResult.fold(
              (l) => emit(
                    state.copyWith(
                      tvShowRecommendationsState: RequestState.Error,
                      message: l.message,
                    ),
                  ),
              (r) => emit(state.copyWith(
                    tvShowRecommendationsState: RequestState.Loaded,
                    tvShowRecommendations: r,
                  ))),
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await insertWatchlistTvShow.execute(event.tvShowDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvShowDetail.id));
    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlistTvShow.execute(event.tvShowDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvShowDetail.id));
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListByIdTvShow.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}

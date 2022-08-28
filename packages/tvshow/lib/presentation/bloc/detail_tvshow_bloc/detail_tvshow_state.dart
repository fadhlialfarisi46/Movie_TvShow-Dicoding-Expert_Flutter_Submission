part of 'detail_tvshow_bloc.dart';

class DetailTvshowState extends Equatable {
  final TvShowDetail? tvShowDetail;
  final List<TvShow> tvShowRecommendations;
  final RequestState tvShowDetailState;
  final RequestState tvShowRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const DetailTvshowState({
    required this.tvShowDetail,
    required this.tvShowRecommendations,
    required this.tvShowDetailState,
    required this.tvShowRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  DetailTvshowState copyWith({
    TvShowDetail? tvShowDetail,
    List<TvShow>? tvShowRecommendations,
    RequestState? tvShowDetailState,
    RequestState? tvShowRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return DetailTvshowState(
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      tvShowRecommendations:
          tvShowRecommendations ?? this.tvShowRecommendations,
      tvShowDetailState: tvShowDetailState ?? this.tvShowDetailState,
      tvShowRecommendationsState:
          tvShowRecommendationsState ?? this.tvShowRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory DetailTvshowState.initial() {
    return const DetailTvshowState(
      tvShowDetail: null,
      tvShowRecommendations: [],
      tvShowDetailState: RequestState.Empty,
      tvShowRecommendationsState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvShowDetail,
        tvShowRecommendations,
        tvShowDetailState,
        tvShowRecommendationsState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}

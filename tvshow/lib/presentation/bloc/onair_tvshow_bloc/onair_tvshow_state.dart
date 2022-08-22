part of 'onair_tvshow_bloc.dart';

abstract class OnairTvshowState extends Equatable {
  const OnairTvshowState();

  @override
  List<Object?> get props => [];
}

class OnairTvshowEmpty extends OnairTvshowState {}

class OnairTvshowLoading extends OnairTvshowState {}

class OnairTvshowLoaded extends OnairTvshowState {
  final List<TvShow> tvShows;

  const OnairTvshowLoaded(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

class OnairTvshowError extends OnairTvshowState {
  final String message;

  const OnairTvshowError(this.message);

  @override
  List<Object?> get props => [message];
}

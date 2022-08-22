import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvshow/tvshow.dart';

class DetailTvShowPage extends StatefulWidget {
  final int id;

  const DetailTvShowPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailTvShowPageState createState() => _DetailTvShowPageState();
}

class _DetailTvShowPageState extends State<DetailTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailTvshowBloc>(context)
          .add(FetchDetailTvShow(widget.id));
      BlocProvider.of<DetailTvshowBloc>(context)
          .add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailTvshowBloc, DetailTvshowState>(
        listener: (context, state) {
          if (state.watchlistMessage ==
                  DetailTvshowBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  DetailTvshowBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.watchlistMessage),
            ));
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.watchlistMessage),
                  );
                });
          }
        },
        listenWhen: (previousState, currentState) =>
            previousState.watchlistMessage != currentState.watchlistMessage &&
            currentState.watchlistMessage != '',
        builder: (context, state) {
          if (state.tvShowDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvShowDetailState == RequestState.Loaded) {
            debugPrint('tvshow ${state.tvShowDetail}');
            final tvShow = state.tvShowDetail!;
            return SafeArea(
              child: DetailContentTvShow(
                tvShow: tvShow,
                isAddedToWatchlist: state.isAddedToWatchlist,
                recommendations: state.tvShowRecommendations,
              ),
            );
          } else if (state.tvShowDetailState == RequestState.Error) {
            return Center(child: Text(state.message, style: kSubtitle));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContentTvShow extends StatelessWidget {
  final TvShowDetail tvShow;
  final bool isAddedToWatchlist;
  final List<TvShow> recommendations;

  const DetailContentTvShow(
      {Key? key,
      required this.tvShow,
      required this.isAddedToWatchlist,
      required this.recommendations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                tvShow.name,
                                style: kHeading5,
                              ),
                            ),
                            Center(
                              child: Text(
                                '"${tvShow.tagline}"',
                                style: kSubtitle,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedToWatchlist) {
                                  context
                                      .read<DetailTvshowBloc>()
                                      .add(AddToWatchlist(tvShow));
                                  context
                                      .read<DetailTvshowBloc>()
                                      .add(LoadWatchlistStatus(tvShow.id));
                                } else {
                                  context
                                      .read<DetailTvshowBloc>()
                                      .add(RemoveFromWatchlist(tvShow));
                                  context
                                      .read<DetailTvshowBloc>()
                                      .add(LoadWatchlistStatus(tvShow.id));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage / 2}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview.isNotEmpty
                                  ? tvShow.overview
                                  : 'no overview',
                            ),
                            const SizedBox(height: 16),
                            tvShow.seasons.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Season",
                                        style: kHeading6,
                                      ),
                                      SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final tv = tvShow.seasons[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: tvShow.seasons.length,
                                          ))
                                    ],
                                  )
                                : Container(),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<DetailTvshowBloc, DetailTvshowState>(
                              builder: (context, state) {
                                if (state.tvShowRecommendationsState ==
                                    RequestState.Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.tvShowRecommendationsState ==
                                    RequestState.Error) {
                                  return Text(state.message);
                                } else if (state.tvShowRecommendationsState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: state
                                            .tvShowRecommendations.isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final tvshow = state
                                                  .tvShowRecommendations[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      DETAIL_TVSHOW_ROUTE,
                                                      arguments: tvshow.id,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                      itemCount: state
                                                .tvShowRecommendations.length,
                                          )
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: Text('No recommendation',
                                                style: kBodyText),
                                          ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

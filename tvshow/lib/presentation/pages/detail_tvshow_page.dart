import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../provider/detail_tvshow_notifier.dart';

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
      Provider.of<DetailTvShowNotifier>(context, listen: false)
          .fetchDetailTvShow(widget.id);
      Provider.of<DetailTvShowNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailTvShowNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowState == RequestState.Loaded) {
            final tvShow = provider.detailTvShow;
            return SafeArea(
              child: DetailContentTvShow(
                tvShow: tvShow,
                isAddedToWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContentTvShow extends StatelessWidget {
  final TvShowDetail tvShow;
  final bool isAddedToWatchlist;

  const DetailContentTvShow(
      {Key? key, required this.tvShow, required this.isAddedToWatchlist})
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
                              onPressed: () async {
                                if (!isAddedToWatchlist) {
                                  Provider.of<DetailTvShowNotifier>(context,
                                          listen: false)
                                      .addWatchlist(tvShow);
                                } else {
                                  Provider.of<DetailTvShowNotifier>(context,
                                          listen: false)
                                      .removeFromWatchlist(tvShow);
                                }
                                final message =
                                    Provider.of<DetailTvShowNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;
                                if (message ==
                                        DetailTvShowNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        DetailTvShowNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
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
                            Consumer<DetailTvShowNotifier>(
                              builder: (context, data, _) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: data.tvShowRecommendations.isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final tv = data
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
                                                      arguments: tv.id,
                                                    );
                                                  },
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
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: data
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

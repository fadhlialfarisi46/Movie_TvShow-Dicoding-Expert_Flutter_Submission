import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/searchpage/search_page.dart';
import 'package:ditonton/presentation/pages/tvshowpages/onair_tvshow_page.dart';
import 'package:ditonton/presentation/pages/tvshowpages/popular_tvshow_page.dart';
import 'package:ditonton/presentation/provider/tvshow_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/tvshow.dart';
import 'detail_tvshow_page.dart';

class TvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/tvshow';

  const TvShowPage({Key? key}) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchOnAirTvShows()
          ..fetchTopRatedTvShows()
          ..fetchPopularTvShows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<TvShowListNotifier>(context, listen: false)
      ..fetchPopularTvShows()
      ..fetchTopRatedTvShows()
      ..fetchOnAirTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME, arguments: 1);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Rated',
                style: kHeading6,
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvShowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.topRatedTvShows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'On Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirTvShowPage.ROUTE_NAME),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.onAirTvShowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.onAirTvShows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvShowPage.ROUTE_NAME),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularTvShowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvShowList(data.popularTvShows);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailTvShowPage.ROUTE_NAME,
                    arguments: tvShow.id,
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Container(
                        height: 25,
                        padding: EdgeInsets.all(4),
                        color: Colors.black12.withOpacity(0.5),
                        child: Text(
                          tvShow.firstAirDate!.year.toString(),
                        ),
                      ),
                    )
                  ],
                )),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}

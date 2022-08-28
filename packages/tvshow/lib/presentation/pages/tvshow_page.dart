import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/entities.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/tvshow_list_bloc/tvshow_list_bloc.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({Key? key}) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PopularTvshowListBloc>(context).add(const TvshowEvent());
      BlocProvider.of<OnAirTvshowListBloc>(context).add(const TvshowEvent());
      BlocProvider.of<TopRatedTvshowListBloc>(context).add(const TvshowEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE, arguments: 1);
            },
            icon: const Icon(Icons.search),
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
              BlocBuilder<TopRatedTvshowListBloc, TvshowListState>(
                  builder: (_, state) {
                if (state is TvshowListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvshowListLoaded) {
                  return TvShowList(tvShows: state.tvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'On Air',
                onTap: () => Navigator.pushNamed(context, ONAIR_TVSHOW_ROUTE),
              ),
              BlocBuilder<OnAirTvshowListBloc, TvshowListState>(
                  builder: (_, state) {
                if (state is TvshowListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvshowListLoaded) {
                  return TvShowList(tvShows: state.tvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_TVSHOW_ROUTE),
              ),
              BlocBuilder<PopularTvshowListBloc, TvshowListState>(
                  builder: (_, state) {
                if (state is TvshowListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvshowListLoaded) {
                  return TvShowList(tvShows: state.tvShows);
                } else {
                  return const Text('Failed');
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
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList({Key? key, required this.tvShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    DETAIL_TVSHOW_ROUTE,
                    arguments: tvShow.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}

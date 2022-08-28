import 'package:core/styles/styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  const WatchlistTvShowsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowsPageState createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<WatchlistTvshowsBloc>(context, listen: false)
          .add(WatchlistTvshowsEvent()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistTvshowsBloc>(context, listen: false)
        .add(WatchlistTvshowsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvshowsBloc, WatchlistTvshowsState>(
          builder: (_, state) {
            if (state is WatchlistTvshowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvshowsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = state.watchlistResult[index];
                  return TvShowCard(
                    tvShow: tvshow,
                  );
                },
                itemCount: state.watchlistResult.length,
              );
            } else if (state is WatchlistTvshowsEmpty) {
              return Center(
                key: const Key('empty_message'),
                child: Text(
                  state.message,
                  style: kHeading6,
                ),
              );
            } else if (state is WatchlistTvshowsError) {
              return Center(
                key: const Key('error_message'),
                child: Text(
                  state.message,
                  style: kHeading6,
                ),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

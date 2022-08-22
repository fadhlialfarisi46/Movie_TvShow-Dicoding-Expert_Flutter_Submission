import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/tvshow.dart';

class PopularTvShowPage extends StatefulWidget {
  const PopularTvShowPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowPageState createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularTvshowBloc>(context, listen: false)
            .add(PopularTvshowEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvshowBloc, PopularTvShowsState>(
          builder: (_, state) {
            if (state is PopularTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShows[index];
                  return TvShowCard(
                    tvShow: tvShow,
                  );
                },
                itemCount: state.tvShows.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/onair_tvshow_notifier.dart';
import '../widgets/tvshow_card_list.dart';

class OnAirTvShowPage extends StatefulWidget {
  const OnAirTvShowPage({Key? key}) : super(key: key);

  @override
  _OnAirTvShowPageState createState() => _OnAirTvShowPageState();
}

class _OnAirTvShowPageState extends State<OnAirTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnAirTvShowsNotifier>(context, listen: false)
            .fetchOnAirTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TvShowCard(tvShow: tvShow);
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
import 'package:core/styles/styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:tvshow/presentation/widgets/tvshow_card_list.dart';

import '../provider/movie_search_notifier.dart';

class SearchPage extends StatelessWidget {
  final int type;

  const SearchPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (type == 0) {
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
                } else {
                  Provider.of<MovieSearchNotifier>(context, listen: false)
                      .fetchTvShowSearch(query);
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  if (type == 0) {
                    final resultMovie = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = resultMovie[index];
                          return MovieCard(
                            movie: movie,
                          );
                        },
                        itemCount: resultMovie.length,
                      ),
                    );
                  } else {
                    final resultTvShow = data.searchTvShowsResult;
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final tvShow = resultTvShow[index];
                          return TvShowCard(tvShow: tvShow);
                        },
                        itemCount: resultTvShow.length,
                      ),
                    );
                  }
                } else if (data.state == RequestState.Empty ||
                    data.state == RequestState.Error) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        data.message,
                        style: kHeading6,
                      ),
                    ),
                  );
                } else {
                  return Expanded(child: Container());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

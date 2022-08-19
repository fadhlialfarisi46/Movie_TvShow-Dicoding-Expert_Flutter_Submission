import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';


class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final int type;

  SearchPage({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
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
                          return MovieCard(movie);
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
                } else if(data.state == RequestState.Empty || data.state == RequestState.Error) {
                  return Expanded(
                    child: Center(
                      child: Text(data.message, style: kHeading6,),
                    ),
                  );
                }
                else {
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

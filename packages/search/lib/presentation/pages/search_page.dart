import 'package:core/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tvshow/presentation/widgets/tvshow_card_list.dart';

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
              onChanged: (query) {
                if (type == 0) {
                  context.read<SearchMoviesBloc>().add(OnQueryChanged(query));
                } else {
                  context.read<SearchTvShowsBloc>().add(OnQueryChanged(query));
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
            type == 0
                ? const _SearchMoviesResultWidget()
                : const _SearchTvShowsResultWidget()
          ],
        ),
      ),
    );
  }
}

class _SearchMoviesResultWidget extends StatelessWidget {
  const _SearchMoviesResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMoviesBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.searchResult;
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(
                  movie: movie,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                state.message,
                style: kHeading6,
              ),
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: Center(
              child: Text(
                state.message,
                style: kHeading6,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _SearchTvShowsResultWidget extends StatelessWidget {
  const _SearchTvShowsResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTvShowsBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.searchResult;
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = result[index];
                return TvShowCard(
                  tvShow: tvShow,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                state.message,
                style: kHeading6,
              ),
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: Center(
              child: Text(
                state.message,
                style: kHeading6,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

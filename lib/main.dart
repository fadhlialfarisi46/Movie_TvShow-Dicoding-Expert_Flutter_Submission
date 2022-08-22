import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tvshow/tvshow.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnAirTvshowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvshowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvshowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<SearchTvShowsBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>()),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvshowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnairTvshowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvshowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvshowsBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case POPULAR_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvShowPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WATCHLIST_TVSHOW_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvShowsPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TVSHOW_ROUTE:
              return MaterialPageRoute(builder: (_) => TvShowPage());
            case ONAIR_TVSHOW_ROUTE:
              return CupertinoPageRoute(builder: (_) => OnAirTvShowPage());
            case DETAIL_TVSHOW_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailTvShowPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              final type = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SearchPage(
                  type: type,
                ),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

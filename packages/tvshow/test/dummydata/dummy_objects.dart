import 'package:core/data/models/models.dart';
import 'package:core/domain/entities/entities.dart';

final testTvshow = TvShow(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
  originalLanguage: 'en',
  originCountry: const ['en'],
  originalName: 'Spider-Man',
  firstAirDate: DateTime.parse('2022-14-08'),
  name: 'Spider-Man',
);

final testTvshowList = [testTvshow];

final testTvShowDetail = TvShowDetail(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: const [1],
  firstAirDate: DateTime.parse('2022-14-08'),
  genres: const [Genre(id: 1, name: 'Action')],
  id: 1,
  languages: const ['en'],
  lastAirDate: DateTime.parse('2022-14-08'),
  lastEpisodeToAir: LastEpisodeToAir(
      airDate: DateTime.parse('2022-14-08'),
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1),
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ['en'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: [
    Season(
        airDate: DateTime.parse('2022-14-08'),
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1)
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  voteAverage: 1,
);

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  voteAverage: 1.toDouble(),
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
  'voteAverage': 1.toDouble(),
};

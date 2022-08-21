part of 'models.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final double? voteAverage;

  const TvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
        voteAverage: tvShow.voteAverage,
      );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        voteAverage: map['voteAverage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
        'voteAverage': voteAverage,
      };

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview, voteAverage];
}

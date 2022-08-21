part of 'models.dart';

class LastEpisodeToAirModel extends Equatable {
  LastEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  DateTime airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"] ?? '-',
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  LastEpisodeToAir toEntity() {
    return LastEpisodeToAir(
        airDate: airDate,
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        productionCode: productionCode,
        runtime: runtime,
        seasonNumber: seasonNumber,
        showId: showId,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

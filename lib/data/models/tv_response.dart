import 'package:ditonton/data/models/tvshow_model.dart';
import 'package:equatable/equatable.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> results;

  TvShowResponse({required this.results});

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        results: List<TvShowModel>.from(
            json["results"].map((x) => TvShowModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}

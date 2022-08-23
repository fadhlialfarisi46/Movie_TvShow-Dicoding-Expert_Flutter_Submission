import 'dart:convert';

import 'package:core/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
      backdropPath: "/eiRLR7HN0hdyYsahegb0FP1Yra0.jpg",
      firstAirDate: DateTime.tryParse("2022-07-28"),
      genreIds: const [18, 9648],
      id: 110531,
      name: "Pretty Little Liars: Original Sin",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "Pretty Little Liars: Original Sin",
      overview:
          "Twenty years ago, a series of tragic events almost ripped the blue-collar town of Millwood apart. Now, in the present day, a group of disparate teen girls finds themselves tormented by an unknown Assailant and made to pay for the secret sin their parents committed two decades ago, as well as their own.",
      popularity: 627.108,
      posterPath: "/igmLgglembi9mZ2RYQRaGKigbvq.jpg",
      voteAverage: 7.9,
      voteCount: 47);
  final tTvShowResponseModel =
      TvShowResponse(results: <TvShowModel>[tTvShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_air.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/eiRLR7HN0hdyYsahegb0FP1Yra0.jpg",
            "first_air_date": "2022-07-28",
            "genre_ids": [18, 9648],
            "id": 110531,
            "name": "Pretty Little Liars: Original Sin",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Pretty Little Liars: Original Sin",
            "overview":
                "Twenty years ago, a series of tragic events almost ripped the blue-collar town of Millwood apart. Now, in the present day, a group of disparate teen girls finds themselves tormented by an unknown Assailant and made to pay for the secret sin their parents committed two decades ago, as well as their own.",
            "popularity": 627.108,
            "poster_path": "/igmLgglembi9mZ2RYQRaGKigbvq.jpg",
            "vote_average": 7.9,
            "vote_count": 47
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

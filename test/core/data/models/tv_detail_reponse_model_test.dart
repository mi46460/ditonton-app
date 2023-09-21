import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_detail_model_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetailModel = TVDetailModel(
      adult: false,
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      id: 112470,
      genres: const <GenreModel>[GenreModel(id: 10766, name: "Soap")],
      title: "Here it all begins",
      overview: "",
      numberOfEpisodes: 733,
      numberOfSeasons: 1,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      popularity: 4381.194,
      originalname: "Ici tout commence",
      voteAverage: 6.619,
      voteCount: 21);

  final tTvDetailResponseModel = TVDetailResponse(tvDetail: tTvDetailModel);

  group('From Json', () {
    test('should return a valid model from json', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));

      //act
      final result = TVDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvDetailResponseModel);
    });
  });

  group('to json', () {
    test('should return valid json', () {
      //arrange
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
        "id": 112470,
        "genres": [
          {"id": 10766, "name": "Soap"}
        ],
        "name": "Here it all begins",
        "overview": "",
        "number_of_episodes": 733,
        "number_of_seasons": 1,
        "poster_path": "/60cqjI590JKXCAABqCStVmSBGET.jpg",
        "popularity": 4381.194,
        "original_name": "Ici tout commence",
        "vote_average": 6.619,
        "vote_count": 21
      };

      //act
      final result = tTvDetailResponseModel.toJson();

      //assert
      expect(result, expectedJsonMap);
    });
  });
}

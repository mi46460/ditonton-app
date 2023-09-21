import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_reponse.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import '../../json_reader.dart';

void main() {
  final tTvModel = TVModel(
      backdropPath: '/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg',
      genreIds: [10766],
      id: 112470,
      name: "Here it all begins",
      originalName: "Ici tout commence",
      overview: "",
      popularity: 5208.508,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      voteAverage: 6.7,
      voteCount: 17);

  final tTvResponseModel = TVResponse(tvList: <TVModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_on_the_air.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": '/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg',
            "genre_ids": [10766],
            "id": 112470,
            "name": "Here it all begins",
            "original_name": "Ici tout commence",
            "overview": "",
            "popularity": 5208.508,
            "poster_path": "/60cqjI590JKXCAABqCStVmSBGET.jpg",
            "vote_average": 6.7,
            "vote_count": 17
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

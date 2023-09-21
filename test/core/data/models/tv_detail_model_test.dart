import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final tTvDetail = TvDetail(
      adult: false,
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      id: 112470,
      genres: <Genre>[Genre(id: 10766, name: "Soap")],
      name: "Here it all begins",
      overview: "",
      numberOfEpisodes: 733,
      numberOfSeasons: 1,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      popularity: 4381.194,
      originalname: "Ici tout commence",
      voteAverage: 6.619,
      voteCount: 21);

  test("shoud be subclass of Tv Detail", () {
    //act
    final result = tTvDetailModel.toEntitiy();

    //assert
    expect(result, tTvDetail);
  });
}

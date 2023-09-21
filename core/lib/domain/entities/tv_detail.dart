import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvDetail extends Equatable {
  TvDetail(
      {required this.adult,
      required this.backdropPath,
      required this.id,
      required this.genres,
      required this.name,
      required this.overview,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.posterPath,
      required this.popularity,
      required this.originalname,
      required this.voteAverage,
      required this.voteCount});

  bool adult;
  String? backdropPath;
  int id;
  List<Genre> genres;
  String name;
  String overview;
  int numberOfEpisodes;
  int numberOfSeasons;
  String posterPath;
  double popularity;
  String originalname;
  double voteAverage;
  int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        id,
        genres,
        name,
        overview,
        numberOfEpisodes,
        numberOfSeasons,
        posterPath,
        popularity,
        originalname,
        voteAverage,
        voteCount
      ];
}

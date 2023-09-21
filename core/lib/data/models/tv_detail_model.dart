import 'package:equatable/equatable.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_detail.dart';
import 'genre_model.dart';

class TVDetailModel extends Equatable {
  TVDetailModel(
      {required this.adult,
      required this.backdropPath,
      required this.id,
      required this.genres,
      required this.title,
      required this.overview,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.posterPath,
      required this.popularity,
      required this.originalname,
      required this.voteAverage,
      required this.voteCount});

  final bool adult;
  final String? backdropPath;
  final int id;
  final List<GenreModel> genres;
  final String title;
  final String overview;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String posterPath;
  final double popularity;
  final String originalname;
  final double voteAverage;
  final int voteCount;

  factory TVDetailModel.fromJson(Map<String, dynamic> json) => TVDetailModel(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      id: json["id"],
      genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x))),
      title: json["name"],
      overview: json["overview"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      originalname: json["original_name"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"]);

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "genres":
            List<dynamic>.from(genres.map((x) => {"id": x.id, "name": x.name})),
        "name": title,
        "overview": overview,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "poster_path": posterPath,
        "popularity": popularity,
        "original_name": originalname,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntitiy() {
    return TvDetail(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      genres: List<Genre>.from(genres.map((genre) => genre.toEntity())),
      name: title,
      overview: overview,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      posterPath: posterPath,
      popularity: popularity,
      originalname: originalname,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        id,
        genres,
        title,
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

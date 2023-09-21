import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TVModel extends Equatable {
  TVModel(
      {required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? name;
  final String? originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      name: json["name"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount
      };

  TV toEntity() {
    return TV(
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        name: name,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        name,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}

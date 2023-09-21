import 'package:equatable/equatable.dart';

class TV extends Equatable {
  TV(
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

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? name;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  TV.watchList(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name});

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

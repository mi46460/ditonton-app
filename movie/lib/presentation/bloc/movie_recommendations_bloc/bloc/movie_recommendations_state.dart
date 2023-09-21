part of 'movie_recommendations_bloc.dart';

@immutable
sealed class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationsEmpty extends MovieRecommendationsState {}

final class MovieRecommendatiosLoading extends MovieRecommendationsState {}

final class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> movieRecommendations;

  const MovieRecommendationsHasData(this.movieRecommendations);

  @override
  List<Object> get props => [movieRecommendations];
}

final class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  const MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

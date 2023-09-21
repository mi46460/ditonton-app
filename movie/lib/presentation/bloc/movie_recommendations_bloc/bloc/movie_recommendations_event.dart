part of 'movie_recommendations_bloc.dart';

@immutable
sealed class MovieRecommendationsEvent {}

final class OnFetchMovieRecommendations extends MovieRecommendationsEvent {
  final int id;

  OnFetchMovieRecommendations(this.id);
}

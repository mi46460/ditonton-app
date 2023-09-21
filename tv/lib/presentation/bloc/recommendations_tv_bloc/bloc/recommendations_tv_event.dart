part of 'recommendations_tv_bloc.dart';

@immutable
sealed class RecommendationsTvEvent {}

class OnFetchTvRecommendations extends RecommendationsTvEvent {
  final int id;

  OnFetchTvRecommendations(this.id);
}

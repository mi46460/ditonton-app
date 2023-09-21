part of 'recommendations_tv_bloc.dart';

@immutable
sealed class RecommendationsTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RecommendationsTvInitial extends RecommendationsTvState {}

final class RecommendationsTvLoading extends RecommendationsTvState {}

final class RecommendationsTvHasData extends RecommendationsTvState {
  final List<TV> recommendationsTvList;

  RecommendationsTvHasData(this.recommendationsTvList);

  @override
  List<Object?> get props => [recommendationsTvList];
}

final class RecommendationsTvError extends RecommendationsTvState {
  final String message;

  RecommendationsTvError(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'detail_movie_bloc.dart';

@immutable
sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailEmpty extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

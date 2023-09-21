part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

final class PopularMoviesEmpty extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> popularMovies;

  const PopularMoviesHasData(this.popularMovies);

  @override
  List<Object> get props => [popularMovies];
}

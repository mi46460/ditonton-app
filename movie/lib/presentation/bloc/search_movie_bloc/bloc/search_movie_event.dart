part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent {
  const SearchMovieEvent();
}

class OnQueryChanged extends SearchMovieEvent {
  final String query;

  const OnQueryChanged(this.query);
}

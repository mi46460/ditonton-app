part of 'detail_movie_bloc.dart';

@immutable
sealed class DetailMovieEvent {}

class OnMovieDetail extends DetailMovieEvent {
  final int id;

  OnMovieDetail(this.id);
}

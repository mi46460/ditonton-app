part of 'search_tv_bloc.dart';

@immutable
sealed class SearchTvEvent {}

final class OnSearchTv extends SearchTvEvent {
  final String query;

  OnSearchTv(this.query);
}

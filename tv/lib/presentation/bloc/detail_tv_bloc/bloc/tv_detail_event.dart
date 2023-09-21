part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailEvent {}

final class OnFetchTvDetail extends TvDetailEvent {
  final int id;

  OnFetchTvDetail(this.id);
}

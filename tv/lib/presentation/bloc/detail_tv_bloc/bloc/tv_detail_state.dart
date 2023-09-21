part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailHasData extends TvDetailState {
  final TvDetail tvDetail;

  TvDetailHasData(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

final class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

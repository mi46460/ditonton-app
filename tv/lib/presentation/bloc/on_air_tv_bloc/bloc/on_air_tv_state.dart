part of 'on_air_tv_bloc.dart';

@immutable
sealed class OnAirTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class OnAirTvInitial extends OnAirTvState {}

final class OnAirTvLoading extends OnAirTvState {}

final class OnAirTvHasData extends OnAirTvState {
  final List<TV> onAirTvList;

  OnAirTvHasData(this.onAirTvList);

  @override
  List<Object?> get props => [onAirTvList];
}

final class OnAirTvError extends OnAirTvState {
  final String message;

  OnAirTvError(this.message);

  @override
  List<Object?> get props => [message];
}

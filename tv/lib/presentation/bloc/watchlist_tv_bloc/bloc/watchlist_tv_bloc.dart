import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetWatchListTv getWatchListTv;
  final GetWatchListTvStatus getWatchListStatus;

  WatchlistTvBloc(
      {required this.getWatchListStatus,
      required this.getWatchListTv,
      required this.removeWatchlistTv,
      required this.saveWatchListTv})
      : super(WatchlistTvInitial()) {
    on<OnFetchWatchlistData>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await getWatchListTv.execute();

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(WatchlistTvEmpty());
        } else {
          emit(WatchlistTvHasData(data));
        }
      });
    });

    on<OnGetWatchlistStatus>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await getWatchListStatus.execute(event.id);

      emit(WatchlistTvDataIsAdded(result));
    });

    on<OnSaveWatchlist>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await saveWatchListTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(WatchlistTvAddRemoveDataFailed(failure.message));
      }, (message) {
        emit(WatchlistTvAddRemoveDataSuccess(message));
      });
    });

    on<OnRemoveWatchlist>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await removeWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(WatchlistTvAddRemoveDataFailed(failure.message));
      }, (message) {
        emit(WatchlistTvAddRemoveDataSuccess(message));
      });
    });
  }
}

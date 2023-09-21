import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvInitial()) {
    on<OnFetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await getTopRatedTv.execute();

      result.fold((failure) {
        emit(TopRatedTvError(failure.message));
      }, (data) {
        emit(TopRatedTvHasData(data));
      });
    });
  }
}

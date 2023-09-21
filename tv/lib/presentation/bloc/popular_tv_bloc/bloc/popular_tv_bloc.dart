import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvInitial()) {
    on<OnFetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final result = await getPopularTv.execute();

      result.fold((failure) => [emit(PopularTvError(failure.message))],
          (data) => [emit(PopularTvHasData(data))]);
    });
  }
}

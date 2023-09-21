import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(TvDetailInitial()) {
    on<OnFetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final result = await getTvDetail.execute(event.id);

      result.fold((failure) => emit(TvDetailError(failure.message)),
          (data) => emit(TvDetailHasData(data)));
    });
  }
}

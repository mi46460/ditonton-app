import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'recommendations_tv_event.dart';
part 'recommendations_tv_state.dart';

class TvRecommendationsBloc
    extends Bloc<RecommendationsTvEvent, RecommendationsTvState> {
  final GetTvRecommendation getTvRecommendation;
  TvRecommendationsBloc(this.getTvRecommendation)
      : super(RecommendationsTvInitial()) {
    on<OnFetchTvRecommendations>((event, emit) async {
      emit(RecommendationsTvLoading());

      final result = await getTvRecommendation.execute(event.id);

      result.fold((failure) => [emit(RecommendationsTvError(failure.message))],
          (data) => [emit(RecommendationsTvHasData(data))]);
    });
  }
}

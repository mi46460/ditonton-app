import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc(this.getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnFetchMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieRecommendatiosLoading());

      final result = await getMovieRecommendations.execute(id);

      result.fold(
          (failure) => [emit(MovieRecommendationsError(failure.message))],
          (data) => [emit(MovieRecommendationsHasData(data))]);
    });
  }
}

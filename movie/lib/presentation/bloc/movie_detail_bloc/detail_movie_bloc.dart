import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class MovieDetailBloc extends Bloc<DetailMovieEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailEmpty()) {
    on<OnMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(id);

      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}

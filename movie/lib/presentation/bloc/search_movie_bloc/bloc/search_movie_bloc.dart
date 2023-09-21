import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

import 'package:core/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc(this.searchMovies) : super(SearchInitial()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());

        final result = await searchMovies.execute(query);

        result.fold((failure) {
          emit(SearchError(failure.message));
        }, (data) {
          if (data.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchHasData(data));
          }
        });
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper),
    );
  }
}

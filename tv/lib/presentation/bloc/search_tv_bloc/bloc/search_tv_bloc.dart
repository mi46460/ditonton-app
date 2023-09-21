import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv searchTv;

  SearchTvBloc(this.searchTv) : super(SearchTvInitial()) {
    on<OnSearchTv>((event, emit) async {
      emit(SearchTvLoading());

      final result = await searchTv.execute(event.query);

      result.fold((failure) {
        emit(SearchTvError(failure.message));
      }, (data) {
        data.isNotEmpty ? emit(SearchTvHasData(data)) : emit(SearchTvEmpty());
      });
    });
  }
}

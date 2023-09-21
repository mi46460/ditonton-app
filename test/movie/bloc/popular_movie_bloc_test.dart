import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc/bloc/popular_movie_bloc.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(popularMovieBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should change staus to loading and should change status to has data when success fetch data',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));

      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnFetchPopularMovie()),
    expect: () => [PopularMoviesLoading(), PopularMoviesHasData(tMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should change staus to loading and should change status to error when failed fetch data',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Exception")));

      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnFetchPopularMovie()),
    expect: () =>
        [PopularMoviesLoading(), const PopularMoviesError("Server Exception")],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}

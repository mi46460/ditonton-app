import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc/bloc/top_rated_movie_bloc.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedrMovies;

  setUp(() {
    mockGetTopRatedrMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMoviesBloc(mockGetTopRatedrMovies);
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

  test('should have empty state for initial', () {
    expect(topRatedMovieBloc.state, TopRatedMoviesEmpty());
  });

  blocTest(
      'should update state to loading when fetchin data and update state to sucess when success fetch data',
      build: () {
        when(mockGetTopRatedrMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));

        return topRatedMovieBloc;
      },
      act: (bloc) {
        bloc.add(OnFetchTopRatedMovies());
      },
      expect: () =>
          [TopRatedMoviesLoading(), TopRatedMoviesHasData(tMovieList)],
      verify: (bloc) {
        mockGetTopRatedrMovies.execute();
      });

  blocTest(
      'should update state to loading when fetchin data and update state to error when failed fetch data',
      build: () {
        when(mockGetTopRatedrMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Error")));

        return topRatedMovieBloc;
      },
      act: (bloc) {
        bloc.add(OnFetchTopRatedMovies());
      },
      expect: () =>
          [TopRatedMoviesLoading(), TopRatedMoviesError("Server Error")],
      verify: (bloc) {
        mockGetTopRatedrMovies.execute();
      });
}

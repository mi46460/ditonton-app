import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/now_playing_movies_bloc/bloc/now_playing_movies_bloc.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('should return empty data state for initial', () {
    //arrange
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
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

  blocTest(
    'should change state to loading when fetching and state to has data when success',
    build: () {
      //arrange
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));

      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
    expect: () =>
        [NowPlayingMoviesLoading(), NowPlayingMoviesHasData(tMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest(
    'should change state to loading when fetching and state to error when failed',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")));

      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError("Server Failure")
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc/bloc/top_rated_tv_bloc.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('should have initial state', () {
    expect(topRatedTvBloc.state, TopRatedTvInitial());
  });

  final tTv = TV(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      originalName: 'Original Name',
      name: 'name');

  final tTvList = <TV>[tTv];

  blocTest(
    'should have state loading when fetching data and state has data when successfully fetch data',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));

      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchTopRatedTv()),
    expect: () => [TopRatedTvLoading(), TopRatedTvHasData(tTvList)],
    verify: (bloc) {
      mockGetTopRatedTv.execute();
    },
  );

  blocTest(
    'should have state loading when fetching data and state error when failed fetch data',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Error")));

      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchTopRatedTv()),
    expect: () => [TopRatedTvLoading(), TopRatedTvError("Server Error")],
    verify: (bloc) {
      mockGetTopRatedTv.execute();
    },
  );
}

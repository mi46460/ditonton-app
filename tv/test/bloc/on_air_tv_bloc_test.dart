import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc/bloc/on_air_tv_bloc.dart';

import 'on_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTv])
void main() {
  late MockGetOnAirTv mockGetOnAirTv;
  late OnAirTvBloc onAirTvBloc;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTv();
    onAirTvBloc = OnAirTvBloc(mockGetOnAirTv);
  });

  final tTv = TV(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      originalName: 'Original Name',
      name: 'name');

  final tTvList = <TV>[tTv];

  test('should have initial state', () {
    expect(onAirTvBloc.state, OnAirTvInitial());
  });

  blocTest(
    'should have state loading when fetching data and state has data when successfully fetch data',
    build: () {
      when(mockGetOnAirTv.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));

      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchOnAirTv()),
    expect: () => [OnAirTvLoading(), OnAirTvHasData(tTvList)],
    verify: (bloc) {
      mockGetOnAirTv.execute();
    },
  );

  blocTest(
    'should have state loading when fetching data and state error when failed fetch data',
    build: () {
      when(mockGetOnAirTv.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Error")));

      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchOnAirTv()),
    expect: () => [OnAirTvLoading(), OnAirTvError("Server Error")],
    verify: (bloc) {
      mockGetOnAirTv.execute();
    },
  );
}

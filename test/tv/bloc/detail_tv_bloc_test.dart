import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/detail_tv_bloc/bloc/tv_detail_bloc.dart';

import '../dummy_objects/dummy_data.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  const int tId = 1;

  test('should have initial state for first time', () {
    expect(tvDetailBloc.state, TvDetailInitial());
  });

  blocTest(
    'should set state to loading and state has data when success fetch data',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((realInvocation) async => Right(testTvDetail));

      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
    expect: () => [TvDetailLoading(), TvDetailHasData(testTvDetail)],
    verify: (bloc) => [mockGetTvDetail.execute(tId)],
  );

  blocTest(
    'should set state to loading and state error when failed fetch data',
    build: () {
      when(mockGetTvDetail.execute(tId)).thenAnswer(
          (realInvocation) async => Left(DatabaseFailure("Server Failure")));

      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
    expect: () => [TvDetailLoading(), TvDetailError("Server Failure")],
    verify: (bloc) => [mockGetTvDetail.execute(tId)],
  );
}

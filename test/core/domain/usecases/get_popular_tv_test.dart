import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tTv = <TV>[];

  test('test get popular tv', () async {
    //arrange
    when(mockTvRepository.getPopularTv()).thenAnswer((_) async => Right(tTv));

    //execute
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTv));
  });
}

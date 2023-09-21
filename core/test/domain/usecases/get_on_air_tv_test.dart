import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTv usecase;
  late MockTVRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTVRepository();
    usecase = GetOnAirTv(mockTvRepository);
  });

  final tTv = <TV>[];

  test('should get list of on air tv from repository', () async {
    //arrange
    when(mockTvRepository.getOnAirTv()).thenAnswer((_) async => Right(tTv));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTv));
  });
}

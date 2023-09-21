import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository mockTVRepository;
  late SaveWatchListTv usecase;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SaveWatchListTv(mockTVRepository);
  });

  test('should save tv to repository', () async {
    //arrange
    when(mockTVRepository.saveWatchListTv(testTvDetail))
        .thenAnswer((_) async => const Right('Added to watchlist'));
    //act
    final result = await usecase.execute(testTvDetail);
    //assert
    verify(mockTVRepository.saveWatchListTv(testTvDetail));
    expect(result, const Right('Added to watchlist'));
  });
}

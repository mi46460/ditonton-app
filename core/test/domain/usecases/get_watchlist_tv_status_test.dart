import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository mockTVRepository;
  late GetWatchListTvStatus usecase;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchListTvStatus(mockTVRepository);
  });

  final tId = 1;

  test('should return true when data founded in database', () async {
    //arrange
    when(mockTVRepository.isAddedToWatchlist(tId))
        .thenAnswer((realInvocation) async => true);
    //act
    final result = await usecase.execute(tId);
    //assert
    verify(mockTVRepository.isAddedToWatchlist(tId));
    expect(result, true);
  });
}

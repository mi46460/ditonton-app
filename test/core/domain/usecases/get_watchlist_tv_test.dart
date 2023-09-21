import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository mockLocalTvDataSource;
  late GetWatchListTv getWatchListTv;

  setUp(() {
    mockLocalTvDataSource = MockTVRepository();
    getWatchListTv = GetWatchListTv(mockLocalTvDataSource);
  });

  test('should return list of tv watchlist', () async {
    //assert
    when(mockLocalTvDataSource.getWatchListTv())
        .thenAnswer((_) async => Right(testTvList));
    //act
    final result = await getWatchListTv.execute();
    //asssert
    expect(result, Right(testTvList));
  });
}

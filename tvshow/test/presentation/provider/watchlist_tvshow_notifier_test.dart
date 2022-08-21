import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/usecases.dart';
import 'package:tvshow/presentation/provider/watchlist_tvshow_notifier.dart';

import '../../dummydata/dummy_objects.dart';
import 'watchlist_tvshow_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowNotifier provider;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    provider = WatchlistTvShowNotifier(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTvShows.execute())
        .thenAnswer((_) async => Right([testWatchlistTvShow]));
    // act
    await provider.fetchwatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTvShows, [testWatchlistTvShow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvShows.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchwatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
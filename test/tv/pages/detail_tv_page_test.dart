import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/detail_tv_bloc/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/recommendations_tv_bloc/bloc/recommendations_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc/bloc/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../dummy_objects/dummy_data.dart';

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class MockTvRecommendationsBloc
    extends MockBloc<RecommendationsTvEvent, RecommendationsTvState>
    implements TvRecommendationsBloc {}

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvDetailBloc mockTvDetailBloc;

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => mockWatchlistTvBloc,
        ),
        BlocProvider<TvRecommendationsBloc>(
          create: (context) => mockTvRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  group('tv detail tesing', () {
    testWidgets('should display container when state is initial',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailInitial());

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final containerFinder = find.byType(Container);

      expect(containerFinder, findsOneWidget);
    });

    testWidgets(
        'should display circullar progress indicator when state is loading',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoading());

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final widgetFinder = find.byType(CircularProgressIndicator);

      expect(widgetFinder, findsOneWidget);
    });

    testWidgets('should display DetailTvContent when state is has data',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(true));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final widgetFinder = find.byType(DetailTvContent);

      expect(widgetFinder, findsOneWidget);
    });

    testWidgets('should display error message when text is error',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailError('Error'));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final widgetFinder = find.byType(Text);
      final keyFinder = find.byKey(const Key('error_message'));
      final textFinder = find.text('Error');

      expect(widgetFinder, findsOneWidget);
      expect(keyFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });

  group('Watchlist tv testing', () {
    testWidgets(
        'should display circular button indicator in button when state is loading',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final keyFinder = find.byKey(const Key('circular_progress_button'));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets('should display icon check when state is true',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(true));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final iconFinder = find.byIcon(Icons.check);

      expect(iconFinder, findsOneWidget);
    });

    testWidgets('should display icon add when state is true',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));
      final iconFinder = find.byIcon(Icons.add);

      expect(iconFinder, findsOneWidget);
    });

    testWidgets(
        'should called OnAddData event when state added data is false and elevated button is clicked',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final keyFinder = find.byKey(const Key('elevated_button'));

      await widgetTester.tap(keyFinder);

      verify(() => mockWatchlistTvBloc.add(OnSaveWatchlist(testTvDetail)));
    });

    testWidgets(
        'should called OnAddData event when state added data is false and elevated button is clicked',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final keyFinder = find.byKey(const Key('elevated_button'));

      await widgetTester.tap(keyFinder);

      verify(() => mockWatchlistTvBloc.add(OnSaveWatchlist(testTvDetail)));
    });

    testWidgets(
        'should called OnRemoveData event when state added data is true and elevated button is clicked',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(true));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final widgetFinder = find.byType(ElevatedButton);

      await widgetTester.tap(widgetFinder);

      verify(() => mockWatchlistTvBloc.add(OnRemoveWatchlist(testTvDetail)));
    });

    // testWidgets(
    //     'should called OnGetWatchlistStatus event when state is WatchistAddRemoveDataSuccess',
    //     (widgetTester) async {
    //   when(() => mockTvDetailBloc.state)
    //       .thenReturn(TvDetailHasData(testTvDetail));
    //   when(() => mockTvRecommendationsBloc.state)
    //       .thenReturn(RecommendationsTvHasData(testTvList));
    //   when(() => mockWatchlistTvBloc.state)
    //       .thenReturn(WatchlistTvDataIsAdded(true));

    //   await widgetTester
    //       .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

    //   mockWatchlistTvBloc.emit(WatchlistTvAddRemoveDataSuccess('Success'));

    //   await widgetTester.pump();

    //   // when(() => mockWatchlistTvBloc.state)
    //   //     .thenReturn(WatchlistTvAddRemoveDataSuccess('Success'));

    //   final snackbarFinder = find.byType(SnackBar);

    //   // expect(snackbarFinder, findsOneWidget);
    //   verify(() => mockWatchlistTvBloc.add(OnGetWatchlistStatus(tId)));
    // });
  });

  group('tv Recomendations', () {
    testWidgets('should display container when state is initial',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvInitial());
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final keyFinder = find.byKey(const Key('tv_recommendation_container'));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets(
        'should display circular progress indicator when state is loading',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvLoading());
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final keyFinder =
          find.byKey(const Key("circular_progress_recommedations"));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets('should display list view when state has data',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData(testTvList));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final widgetFider = find.byType(ListView);

      expect(widgetFider, findsOneWidget);
    });

    testWidgets('should display error message when state is error',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvError('error recommendations'));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      final keyFinder = find.byKey(const Key('error_message'));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets('should find movie card based on given data',
        (widgetTester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(RecommendationsTvHasData([testTv]));
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvDataIsAdded(false));

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvDetailPage(id: tId)));

      expect(find.byKey(const Key('list_view_content_recommendations')),
          findsNWidgets([testTv].length));
    });
  });
}

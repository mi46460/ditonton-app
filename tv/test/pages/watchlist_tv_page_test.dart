import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc/bloc/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

import '../dummy_objects/dummy_data.dart';

class MockWatchlistBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

void main() {
  late MockWatchlistBloc mockWatchlistBloc;

  setUp(() {
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget makeTestabelWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should return container when state is initial',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistTvInitial());

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));
    final containerFinder = find.byType(Container);

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should return circular progress indicator when state is loading',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistTvLoading());

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));
    final widgetFinder = find.byType(CircularProgressIndicator);

    expect(widgetFinder, findsOneWidget);
  });

  testWidgets('should return list view indicator when state is has data',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistTvHasData([testTv]));

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));
    final widgetFinder = find.byType(ListView);

    expect(widgetFinder, findsOneWidget);
  });

  testWidgets('should return text empty data when there is no data',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistTvEmpty());

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));
    final textFinder = find.text('Empty Data');

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return error message when state is error',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistTvError('Error'));

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));
    final textFinder = find.text('Error');
    final keyFinder = find.byKey(const Key("error_message"));

    expect(textFinder, findsOneWidget);
    expect(keyFinder, findsOneWidget);
  });

  testWidgets('should find movie card based on given data',
      (widgetTester) async {
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistTvHasData([testTv]));

    await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));

    expect(find.byKey(const Key("tv_card")), findsNWidgets([testTv].length));
  });

  // testWidgets('test didPopNext', (widgetTester) async {
  //   when(() => mockWatchlistBloc.state)
  //       .thenReturn(WatchlistTvHasData([testTv]));

  //   await widgetTester.pumpWidget(makeTestabelWidget(WatchlistTvPage()));

  //   await widgetTester.runAsync(() async {
  //     widgetTester.binding
  //         .handleAppLifecycleStateChanged(AppLifecycleState.inactive);
  //     widgetTester.binding
  //         .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  //   });

  //   verify(() => mockWatchlistBloc.add(OnFetchWatchlistData())).called(1);
  // });
}

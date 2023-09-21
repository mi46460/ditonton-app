import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_pages.dart';

import '../dummy_objects/dummy_data.dart';

class MockTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display container when state is initial',
      (widgetTester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvInitial());

    await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    final containerFinder = find.byType(Container);

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should display circular progress indicator when loading',
      (widgetTester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should display list view when have data', (tester) async {
    //arraange
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvHasData([testTv]));

    //act
    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));
    final listViewFinder = find.byType(ListView);

    //assert
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message when error', (tester) async {
    //arraange
    when(() => mockTopRatedTvBloc.state).thenReturn(TopRatedTvError("Error"));

    //act
    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));
    final textFinder = find.text("Error");
    final keyFinder = find.byKey(const Key("error_message"));

    //assert
    expect(textFinder, findsOneWidget);
    expect(keyFinder, findsOneWidget);
  });

  testWidgets('should find movie card based on given data',
      (widgetTester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvHasData([testTv]));

    await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(find.byKey(const Key("tv_card")), findsNWidgets([testTv].length));
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../dummy_objects/dummy_data.dart';

class MockOnAirTvBloc extends MockBloc<OnAirTvEvent, OnAirTvState>
    implements OnAirTvBloc {}

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class MockTopRatedTvbloc extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

void main() {
  late MockOnAirTvBloc mockOnAirTvBloc;
  late MockTopRatedTvbloc mockTopRatedTvbloc;
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockOnAirTvBloc = MockOnAirTvBloc();
    mockPopularTvBloc = MockPopularTvBloc();
    mockTopRatedTvbloc = MockTopRatedTvbloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnAirTvBloc>(
          create: (context) => mockOnAirTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => mockTopRatedTvbloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => mockPopularTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display container when state is initial',
      (widgetTester) async {
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvInitial());
    when(() => mockTopRatedTvbloc.state).thenReturn(TopRatedTvInitial());
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvInitial());

    await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    final containerFinder = find.byType(Container);

    expect(containerFinder, findsNWidgets(3));
  });

  testWidgets(
      'should display circular progress indicator when state is loading',
      (widgetTester) async {
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvLoading());
    when(() => mockTopRatedTvbloc.state).thenReturn(TopRatedTvLoading());
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    final widgetFinder = find.byType(CircularProgressIndicator);

    expect(widgetFinder, findsNWidgets(3));
  });

  testWidgets(
      'should display TvList widget and ListView widget when state is has data',
      (widgetTester) async {
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvHasData(testTvList));
    when(() => mockTopRatedTvbloc.state)
        .thenReturn(TopRatedTvHasData(testTvList));
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvHasData(testTvList));

    await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    final widgetFinder = find.byType(TvList);
    final listViewFinder = find.byType(ListView);

    expect(widgetFinder, findsNWidgets(3));
    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('should display error message when state is has error',
      (widgetTester) async {
    when(() => mockOnAirTvBloc.state)
        .thenReturn(OnAirTvError('Server Failure'));
    when(() => mockTopRatedTvbloc.state)
        .thenReturn(TopRatedTvError('Server Failure'));
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvError('Server Failure'));

    await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    final textFinder = find.text('Server Failure');

    expect(textFinder, findsNWidgets(3));
  });

  testWidgets('should find list view when data', (widgetTester) async {
    when(() => mockOnAirTvBloc.state).thenReturn(OnAirTvHasData(testTvList));
    when(() => mockTopRatedTvbloc.state)
        .thenReturn(TopRatedTvHasData(testTvList));
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvHasData(testTvList));

    await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    expect(find.byKey(const Key('listview_tv_list')), findsNWidgets(3));
  });
}

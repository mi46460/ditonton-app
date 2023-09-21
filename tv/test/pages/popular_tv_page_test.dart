import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../dummy_objects/dummy_data.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display container when state is initial',
      (widgetTester) async {
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvInitial());

    await widgetTester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    final containerFinder = find.byType(Container);

    expect(containerFinder, findsOneWidget);
  });

  testWidgets(
      'should display circular progress indicator when state is loading',
      (widgetTester) async {
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    await widgetTester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    final circularProgressFinder = find.byType(CircularProgressIndicator);

    expect(circularProgressFinder, findsOneWidget);
  });

  testWidgets('should display list view when state is has data',
      (widgetTester) async {
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvHasData([testTv]));

    await widgetTester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    final listViewFinder = find.byType(ListView);

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (widgetTester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvError('Server Failure'));

    await widgetTester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    final textFinder = find.text('Server Failure');
    final keyFinder = find.byKey(const Key("error_message"));

    expect(textFinder, findsOneWidget);
    expect(keyFinder, findsOneWidget);
  });

  testWidgets('should find tv card based on given data', (widgetTester) async {
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvHasData([testTv]));

    await widgetTester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(find.byKey(const Key("tv_card")), findsNWidgets([testTv].length));
  });
}

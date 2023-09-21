import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  State<StatefulWidget> createState() => _TopRatedTvPage();
}

class _TopRatedTvPage extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvBloc>().add(OnFetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            builder: (context, state) {
          if (state is TopRatedTvInitial) {
            return Container();
          } else if (state is TopRatedTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvHasData) {
            return ListView.builder(
              itemBuilder: (contet, index) {
                final tv = state.topRatedTvList[index];
                return TvCard(tv);
              },
              itemCount: state.topRatedTvList.length,
            );
          } else if (state is TopRatedTvError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Expanded(
              child: Center(
                child: Text("Galad :("),
              ),
            );
          }
        }),
      ),
    );
  }
}

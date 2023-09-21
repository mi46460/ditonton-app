import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvPage({super.key});
  @override
  State<StatefulWidget> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvBloc>().add(OnFetchPopularTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularTvBloc, PopularTvState>(
            builder: (context, state) {
              if (state is PopularTvInitial) {
                return Container();
              } else if (state is PopularTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.popularTvList[index];
                    return TvCard(tv);
                  },
                  itemCount: state.popularTvList.length,
                );
              } else if (state is PopularTvError) {
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
            },
          )),
    );
  }
}

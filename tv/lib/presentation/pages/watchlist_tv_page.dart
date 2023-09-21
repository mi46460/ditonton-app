import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc/bloc/watchlist_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  @override
  State<StatefulWidget> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(OnFetchWatchlistData()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(OnFetchWatchlistData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
              builder: (context, state) {
            if (state is WatchlistTvInitial) {
              return Container();
            } else if (state is WatchlistTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.watchlistTvList[index];
                  return TvCard(tv);
                },
                itemCount: state.watchlistTvList.length,
              );
            } else if (state is WatchlistTvEmpty) {
              return const Center(
                child: Text('Empty Data'),
              );
            } else if (state is WatchlistTvError) {
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
          })),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

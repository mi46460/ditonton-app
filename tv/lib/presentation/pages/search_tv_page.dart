import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvBloc>().add(OnSearchTv(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, SearchTvState>(
                builder: ((context, state) {
              if (state is SearchTvInitial) {
                return Container();
              } else if (state is SearchTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvHasData) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tv = state.searchTvData[index];
                      return TvCard(tv);
                    },
                    itemCount: state.searchTvData.length,
                  ),
                );
              } else if (state is SearchTvEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("Empty Data"),
                  ),
                );
              } else if (state is SearchTvError) {
                return Expanded(
                  child: Center(
                    key: const Key("error_message"),
                    child: Text(state.message),
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Text("Galad :("),
                  ),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}

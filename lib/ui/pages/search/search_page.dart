import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

import 'widgets/search_result_widget.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    searchController.text = searchBloc.state.term;

    searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        searchBloc.add(ChangeTerm(searchController.text));
      });
    });

    final subscribedSourcesBloc = context.read<SubscribedSourcesBloc>();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: RosasTextField(
          placeholder: S.of(context).search,
          theme: Theme.of(context),
          controller: searchController,
          autofocus: true,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        elevation: 0,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              late final List<RosasSource> itemsToShow;

              if (state.term.isNotEmpty) {
                itemsToShow = state.results;
              } else {
                itemsToShow = subscribedSourcesBloc.state.subscribedSources;
              }

              return SingleChildScrollView(
                child: Column(
                  children: itemsToShow.asMap().entries.map((entry) {
                    int idx = entry.key;
                    RosasSource result = entry.value;

                    late final EdgeInsets padding;

                    if (idx == 0) {
                      padding = const EdgeInsets.only(bottom: 8);
                    } else if (idx == itemsToShow.length - 1) {
                      padding = const EdgeInsets.only(top: 8);
                    } else {
                      padding = const EdgeInsets.symmetric(vertical: 8);
                    }

                    return Padding(
                        padding: padding, child: SearchResult(result: result));
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

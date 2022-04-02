import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/models/models_barrel.dart';

class SearchResult extends StatelessWidget {
  final RosasSource result;

  const SearchResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subscribedSourcesBloc = context.read<SubscribedSourcesBloc>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: result.iconUrl.isNotEmpty
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(result.iconUrl),
                )
              : Container(color: Colors.white),
        ),
        const SizedBox(
          width: 12,
          height: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result.title,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              Text(result.topics.map((topic) => topic.name).join(', '),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
          height: 12,
        ),
        IconButton(
          onPressed: () {
            subscribedSourcesBloc.add(ToggleSubscriptionSource(result));
          },
          icon: BlocBuilder<SubscribedSourcesBloc, SubscribedSourcesState>(
            builder: (context, state) {
              if (state.subscribedSources.contains(result)) {
                return const Icon(Icons.check_rounded);
              } else {
                return const Icon(Icons.add_rounded);
              }
            },
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

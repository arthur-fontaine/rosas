import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

class SourcePageArguments {
  final RosasSource source;

  SourcePageArguments(this.source);
}

class SourcePage extends StatefulWidget {
  static const String route = 'source';

  final RosasSource source;

  const SourcePage({Key? key, required this.source}) : super(key: key);

  @override
  State<SourcePage> createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  late RosasSource source;

  @override
  void initState() {
    source = widget.source;

    source.fetchArticles().then((newSource) {
      setState(() {
        source = newSource;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context).colorScheme.background,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    final subscribedSourcesBloc = context.read<SubscribedSourcesBloc>();
    final notificationsBloc = context.read<NotificationsBloc>();

    return Scaffold(
      // TODO: make the title go in the appbar when scrolling
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
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
        color: Theme.of(context).colorScheme.background,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.network(source.iconUrl),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Text(
                        source.title,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      Text(
                        source.topics.map((topic) => topic.name).join(', '),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<SubscribedSourcesBloc,
                          SubscribedSourcesState>(
                        builder: (context, state) {
                          if (state.subscribedSources.contains(source)) {
                            return RosasTextButton(
                                text: S.of(context).subscribed,
                                fill: false,
                                onClick: () {
                                  subscribedSourcesBloc
                                      .add(UnsubscribeSource(source));
                                });
                          } else {
                            return RosasTextButton(
                                text: S.of(context).subscribe,
                                fill: true,
                                onClick: () {
                                  subscribedSourcesBloc
                                      .add(SubscribeSource(source));
                                });
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      BlocBuilder<NotificationsBloc, NotificationsState>(
                        builder: (context, state) {
                          if (state.subscribedSources.contains(source)) {
                            return RosasIconButton(
                                iconData: Icons.notifications_rounded,
                                fill: false,
                                onClick: () {
                                  notificationsBloc
                                      .add(UnsubscribeNotification(source));
                                });
                          } else {
                            return RosasIconButton(
                                iconData: Icons.notification_add_rounded,
                                fill: true,
                                onClick: () {
                                  notificationsBloc
                                      .add(SubscribeNotification(source));
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: source.articles
                    .map((article) => ArticlePreview(article: article))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/banner_type_widget.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool showFirstTime;
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    showFirstTime = true;

    SharedPreferences.getInstance().then((prefs) {
      final alreadyVisited = prefs.getBool('already_visited');
      setState(() {
        showFirstTime = !(alreadyVisited == true);
        _sharedPreferences = prefs;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: const Color.fromRGBO(230, 230, 230, 1),
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1.0),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: Row(
              children: [
                Text('Rosas',
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                Image.asset('assets/logo/rosas-logo-512.png',
                    height: 12, width: 12)
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
        leadingWidth: 100,
        actions: !showFirstTime
            ? <Widget>[
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 0) {
                      Navigator.pushNamed(context, SettingsPage.route);
                    } else if (value == 1) {
                      context
                          .read<NotificationsBloc>()
                          .add(ReadAllNotifications());
                    }
                  },
                  elevation: 2,
                  child: Container(
                    height: 36,
                    width: 48,
                    padding: const EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.more_vert_rounded,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text(S.of(context).settings),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text(S.of(context).markAllAsRead),
                        value: 1,
                      ),
                    ];
                  },
                ),
              ]
            : [],
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            color: Theme.of(context).colorScheme.background,
            child: BlocBuilder<SubscribedSourcesBloc, SubscribedSourcesState>(
              builder: (context, state) {
                if (state.subscribedSources.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<NotificationsBloc, NotificationsState>(
                          builder: (context, state) {
                            if (state.notifications.isNotEmpty) {
                              return Column(
                                children: [
                                  const BannerTypeWidget(
                                      type: BannerType.notifications),
                                  ...(state.notifications
                                        ..sort((a, b) => b.published
                                            .difference(a.published)
                                            .inMilliseconds))
                                      .map((notification) {
                                    if (notification.article != null) {
                                      return ArticlePreview(
                                          article: notification.article!);
                                    }
                                  }).whereType<ArticlePreview>(),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        BlocBuilder<ReadLaterBloc, ReadLaterState>(
                          builder: (context, state) {
                            if (state.articles.isNotEmpty) {
                              return Column(
                                children: [
                                  const BannerTypeWidget(
                                      type: BannerType.readLater),
                                  ...(state.articles
                                        ..sort((a, b) => b.published
                                            .difference(a.published)
                                            .inMilliseconds))
                                      .map((article) {
                                    return ArticlePreview(article: article);
                                  }),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        BlocBuilder<SubscribedSourcesBloc,
                            SubscribedSourcesState>(
                          builder: (context, state) {
                            final articles = state.subscribedSources
                                .map((source) => source.articles)
                                .expand((i) => i)
                                .toList()
                              ..sort((a, b) => b.published
                                  .difference(a.published)
                                  .inMilliseconds);

                            if (articles.isNotEmpty) {
                              return Column(
                                children: [
                                  const BannerTypeWidget(type: BannerType.feed),
                                  ...articles.map((article) {
                                    return ArticlePreview(article: article);
                                  }),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 104),
                    child: XState(
                      illustration: Image.asset(
                          'assets/images/no-subscription-illustration.png'),
                      title: S.of(context).noSubscription,
                      description: S.of(context).noSubscriptionMessage,
                    ),
                  );
                }
              },
            ),
          ),
          showFirstTime
              ? FirstTime(onContinue: () {
                  setState(() {
                    showFirstTime = false;
                  });

                  if (_sharedPreferences != null) {
                    _sharedPreferences!.setBool('already_visited', true);
                  }
                })
              : Container(),
        ],
      ),
      floatingActionButton: !showFirstTime
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SearchPage.route,
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.search_rounded),
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ThemeRepository()),
        RepositoryProvider(create: (context) => NotificationsRepository()),
        RepositoryProvider(create: (context) => ReadLaterRepository()),
        RepositoryProvider(create: (context) => SubscribedSourcesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
              create: (context) =>
                  ThemeBloc(themeRepository: context.read<ThemeRepository>())),
          BlocProvider<NotificationsBloc>(
              create: (context) => NotificationsBloc(
                  notificationsRepository:
                      context.read<NotificationsRepository>())),
          BlocProvider<ReadLaterBloc>(
              create: (context) => ReadLaterBloc(
                  readLaterRepository: context.read<ReadLaterRepository>())),
          BlocProvider<SubscribedSourcesBloc>(
              create: (context) => SubscribedSourcesBloc(
                  subscribedSourcesRepository:
                      context.read<SubscribedSourcesRepository>())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Rosas',
              theme: state.themeData,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('fr', ''),
              ],
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case HomePage.route:
                    return MaterialPageRoute(builder: (_) => const HomePage());
                  default:
                    return MaterialPageRoute(builder: (_) => const HomePage());
                }
              },
            );
          },
        ),
      ),
    );
  }
}

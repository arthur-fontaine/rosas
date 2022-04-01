import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

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
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: state.themeData,
              home: const MyHomePage(),
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

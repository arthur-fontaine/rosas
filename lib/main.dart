import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rosas/firebase/firebase_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/notifications/notifications_page.dart';
import 'package:rosas/ui/search/widgets/subscribed_feeds/subscribed_feeds_barrel.dart';
import 'package:rosas/ui/ui_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Rosas',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          background: Color.fromRGBO(12, 12, 12, 1),
          // background: Color.fromRGBO(23, 23, 23, 1),
          onBackground: Colors.white,
          primary: Colors.white,
          onPrimary: Color.fromRGBO(12, 12, 12, 1),
          // onPrimary: Color.fromRGBO(23, 23, 23, 1),
          secondary: Color.fromRGBO(218, 0, 55, 1),
          onSecondary: Colors.white,
          error: Color.fromRGBO(218, 0, 55, 1),
          onError: Colors.white,
          surface: Color.fromRGBO(68, 68, 68, 1),
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Archivo',
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        dividerColor: const Color.fromRGBO(68, 68, 68, 1),
      ),
      navigatorKey: _navigator,
      initialRoute: '/home',
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SafeArea(
                  child: MultiRepositoryProvider(
                    providers: [
                      RepositoryProvider(
                          create: (context) => FeedsRepository()),
                      RepositoryProvider(
                          create: (context) => SearchRepository()),
                      RepositoryProvider(
                          create: (context) => NotificationsRepository()),
                    ],
                    child: MultiBlocProvider(providers: [
                      BlocProvider<SubscribedFeedsBloc>(
                          create: (context) => SubscribedFeedsBloc(
                              feedsRepository:
                                  context.read<FeedsRepository>())),
                    ], child: child ?? Container()),
                  ),
                ),
                bottomNavigationBar: Navbar(
                  onTabTapped: (tab) {
                    switch (tab) {
                      case NavbarTabs.home:
                        _navigator.currentState?.popAndPushNamed('/home');
                        break;
                      case NavbarTabs.search:
                        _navigator.currentState
                            ?.pushReplacementNamed('/search');
                        break;
                      case NavbarTabs.bell:
                        _navigator.currentState
                            ?.pushReplacementNamed('/notifications');
                        break;
                      // case NavbarTabs.cog:
                      //   _navigator.currentState
                      //       ?.pushReplacementNamed('/settings');
                      //   break;
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
      routes: <String, WidgetBuilder>{
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/settings': (context) => Container(),
      },
    );
  }
}

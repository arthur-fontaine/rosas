import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:rosas/utils/util_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? prefs;

  const MyApp({Key? key, this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ThemeRepository()),
        RepositoryProvider(create: (context) => NotificationsRepository()),
        RepositoryProvider(create: (context) => ReadLaterRepository()),
        RepositoryProvider(create: (context) => SubscribedSourcesRepository()),
        RepositoryProvider(create: (context) => SearchRepository()),
        RepositoryProvider(create: (context) => AuthRepository()),
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
          BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(
                  searchRepository: context.read<SearchRepository>())),
          BlocProvider<AuthBloc>(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final authBloc = context.read<AuthBloc>();

            auth.userChanges().listen((User? user) async {
              if (user == null) {
                authBloc.add(UnsetUser());
              } else {
                authBloc.add(ChangeUser(user));

                try {
                  final doc = await users.doc(user.uid).get();

                  if (!doc.exists) {
                    initUser(user);
                  }
                } catch (e) {
                  rethrow;
                }
              }
            });

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
                  case SearchPage.route:
                    return MaterialPageRoute(
                        builder: (_) => const SearchPage());
                  case ArticlePage.route:
                    final args = settings.arguments as ArticlePageArguments;
                    return MaterialPageRoute(
                        builder: (_) => ArticlePage(article: args.article));
                  case SourcePage.route:
                    final args = settings.arguments as SourcePageArguments;
                    return MaterialPageRoute(
                        builder: (_) => SourcePage(source: args.source));
                  case AuthPage.route:
                    return MaterialPageRoute(builder: (_) => const AuthPage());
                  case LoginPage.route:
                    return MaterialPageRoute(builder: (_) => const LoginPage());
                  case SignupPage.route:
                    return MaterialPageRoute(
                        builder: (_) => const SignupPage());
                  case SettingsPage.route:
                    return MaterialPageRoute(
                        builder: (_) => const SettingsPage());
                  case AccountSettingsPage.route:
                    return MaterialPageRoute(
                        builder: (_) => const AccountSettingsPage());
                  case CheckPasswordPage.route:
                    final args =
                        settings.arguments as CheckPasswordPageArguments;
                    return MaterialPageRoute(
                        builder: (_) =>
                            CheckPasswordPage(callback: args.callback));
                  case ChangeEmailPage.route:
                    return MaterialPageRoute(builder: (_) => const ChangeEmailPage());
                  case ChangePasswordPage.route:
                    return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
                  case DeleteAccountPage.route:
                    return MaterialPageRoute(builder: (_) => const DeleteAccountPage());
                  default:
                    final alreadyVisited = prefs?.getBool('already_visited');
                    if (authBloc.state.user == null && alreadyVisited != true) {
                      return MaterialPageRoute(
                          builder: (_) => const AuthPage());
                    } else {
                      if (authBloc.state.user == null) {
                        auth.signInAnonymously();
                      }

                      return MaterialPageRoute(
                          builder: (_) => const HomePage());
                    }
                }
              },
            );
          },
        ),
      ),
    );
  }
}

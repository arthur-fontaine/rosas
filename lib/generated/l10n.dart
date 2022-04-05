// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your feed`
  String get yourFeed {
    return Intl.message(
      'Your feed',
      name: 'yourFeed',
      desc: '',
      args: [],
    );
  }

  /// `Read later`
  String get readLater {
    return Intl.message(
      'Read later',
      name: 'readLater',
      desc: '',
      args: [],
    );
  }

  /// `Unread notifications`
  String get unreadNotifications {
    return Intl.message(
      'Unread notifications',
      name: 'unreadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllAsRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Read more ({otherPartsNumber} other parts)`
  String readMore(int otherPartsNumber) {
    return Intl.message(
      'Read more ($otherPartsNumber other parts)',
      name: 'readMore',
      desc: '',
      args: [otherPartsNumber],
    );
  }

  /// `{formattedDuration} ago`
  String ago(String formattedDuration) {
    return Intl.message(
      '$formattedDuration ago',
      name: 'ago',
      desc: '',
      args: [formattedDuration],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `You have no subscription.`
  String get noSubscription {
    return Intl.message(
      'You have no subscription.',
      name: 'noSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Tap on the search button to subscribe to your favorite media.`
  String get noSubscriptionMessage {
    return Intl.message(
      'Tap on the search button to subscribe to your favorite media.',
      name: 'noSubscriptionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Split reading`
  String get splitReading {
    return Intl.message(
      'Split reading',
      name: 'splitReading',
      desc: '',
      args: [],
    );
  }

  /// `The main feature of Rosas is the split reading. Instead of reading your articles in a huge block, read them as a Twitter thread, in 280 character chunks.`
  String get splitReadingDescription {
    return Intl.message(
      'The main feature of Rosas is the split reading. Instead of reading your articles in a huge block, read them as a Twitter thread, in 280 character chunks.',
      name: 'splitReadingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notifications and Read later`
  String get notificationsAndReadLater {
    return Intl.message(
      'Notifications and Read later',
      name: 'notificationsAndReadLater',
      desc: '',
      args: [],
    );
  }

  /// `Find your notifications and added articles in the Read Later section on the home page. Rosas will automatically move them to the top.`
  String get notificationsAndReadLaterDescription {
    return Intl.message(
      'Find your notifications and added articles in the Read Later section on the home page. Rosas will automatically move them to the top.',
      name: 'notificationsAndReadLaterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Search with !command`
  String get searchWithBangs {
    return Intl.message(
      'Search with !command',
      name: 'searchWithBangs',
      desc: '',
      args: [],
    );
  }

  /// `Search for sources across different services with DuckDuckGo Bangs inspired search.`
  String get searchWithBangsDescription {
    return Intl.message(
      'Search for sources across different services with DuckDuckGo Bangs inspired search.',
      name: 'searchWithBangsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about Rosas Bangs.`
  String get learnMoreAboutBangs {
    return Intl.message(
      'Learn more about Rosas Bangs.',
      name: 'learnMoreAboutBangs',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get tContinue {
    return Intl.message(
      'Continue',
      name: 'tContinue',
      desc: '',
      args: [],
    );
  }

  /// `Sign up or log in.`
  String get signUpOrLogin {
    return Intl.message(
      'Sign up or log in.',
      name: 'signUpOrLogin',
      desc: '',
      args: [],
    );
  }

  /// `Being authenticated allows you to enjoy synchronization between all your devices.`
  String get signUpOrLoginDescription {
    return Intl.message(
      'Being authenticated allows you to enjoy synchronization between all your devices.',
      name: 'signUpOrLoginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Continue without logging in`
  String get continueWithoutLoggingIn {
    return Intl.message(
      'Continue without logging in',
      name: 'continueWithoutLoggingIn',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get userNotFound {
    return Intl.message(
      'No user found for that email.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get wrongPassword {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `You have to provide an email.`
  String get noEmailError {
    return Intl.message(
      'You have to provide an email.',
      name: 'noEmailError',
      desc: '',
      args: [],
    );
  }

  /// `You have to provide a password.`
  String get noPasswordError {
    return Intl.message(
      'You have to provide a password.',
      name: 'noPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `The passwords are not the same.`
  String get passwordsNotSame {
    return Intl.message(
      'The passwords are not the same.',
      name: 'passwordsNotSame',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailAlreadyInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error.`
  String get unknownError {
    return Intl.message(
      'Unknown error.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed`
  String get subscribed {
    return Intl.message(
      'Subscribed',
      name: 'subscribed',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

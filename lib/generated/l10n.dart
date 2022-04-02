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

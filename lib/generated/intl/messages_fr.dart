// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(formattedDuration) => "il y a ${formattedDuration}";

  static String m1(otherPartsNumber) =>
      "Lire plus (encore ${otherPartsNumber} parties)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ago": m0,
        "learnMoreAboutBangs": MessageLookupByLibrary.simpleMessage(
            "Apprenez-en plus à propos des Rosas Bangs."),
        "markAllAsRead":
            MessageLookupByLibrary.simpleMessage("Marquer tout comme lu"),
        "noSubscription": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez aucun abonnement."),
        "noSubscriptionMessage": MessageLookupByLibrary.simpleMessage(
            "Cliquez sur le bouton recherche pour vous abonner à vos medias préférés."),
        "notificationsAndReadLater": MessageLookupByLibrary.simpleMessage(
            "Notifications et À lire plus tard"),
        "notificationsAndReadLaterDescription":
            MessageLookupByLibrary.simpleMessage(
                "Retrouvez les section de vos notifications et de vos articles ajoutés aux À lire plus tard en haut de la page d\'accueil. Rosas les mettra automatiquement en avant."),
        "readLater": MessageLookupByLibrary.simpleMessage("À lire plus tard"),
        "readMore": m1,
        "search": MessageLookupByLibrary.simpleMessage("Recherche"),
        "searchWithBangs":
            MessageLookupByLibrary.simpleMessage("Recherche avec !commande"),
        "searchWithBangsDescription": MessageLookupByLibrary.simpleMessage(
            "Recherchez des sources à travers différents services avec une recherche inspirée des Bangs DuckDuckGo."),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "splitReading":
            MessageLookupByLibrary.simpleMessage("Lecture fractionnée"),
        "splitReadingDescription": MessageLookupByLibrary.simpleMessage(
            "La principale fonctionnalité de Rosas est la lecture fractionnée. Au lieu de lire vos articles en énormes blocs, lisez les comme des threads Twitter, en parties de 280 caractères."),
        "tContinue": MessageLookupByLibrary.simpleMessage("Continuer"),
        "unreadNotifications":
            MessageLookupByLibrary.simpleMessage("Notifications non lues"),
        "yourFeed": MessageLookupByLibrary.simpleMessage("Votre flux")
      };
}

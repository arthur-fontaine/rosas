// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(formattedDuration) => "${formattedDuration} ago";

  static String m1(otherPartsNumber) =>
      "Read more (${otherPartsNumber} other parts)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ago": m0,
        "learnMoreAboutBangs": MessageLookupByLibrary.simpleMessage(
            "Learn more about Rosas Bangs."),
        "markAllAsRead":
            MessageLookupByLibrary.simpleMessage("Mark all as read"),
        "noSubscription":
            MessageLookupByLibrary.simpleMessage("You have no subscription."),
        "noSubscriptionMessage": MessageLookupByLibrary.simpleMessage(
            "Tap on the search button to subscribe to your favorite media."),
        "notificationsAndReadLater": MessageLookupByLibrary.simpleMessage(
            "Notifications and Read later"),
        "notificationsAndReadLaterDescription":
            MessageLookupByLibrary.simpleMessage(
                "Find your notifications and added articles in the Read Later section on the home page. Rosas will automatically move them to the top."),
        "readLater": MessageLookupByLibrary.simpleMessage("Read later"),
        "readMore": m1,
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchWithBangs":
            MessageLookupByLibrary.simpleMessage("Search with !command"),
        "searchWithBangsDescription": MessageLookupByLibrary.simpleMessage(
            "Search for sources across different services with DuckDuckGo Bangs inspired search."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "splitReading": MessageLookupByLibrary.simpleMessage("Split reading"),
        "splitReadingDescription": MessageLookupByLibrary.simpleMessage(
            "The main feature of Rosas is the split reading. Instead of reading your articles in a huge block, read them as a Twitter thread, in 280 character chunks."),
        "tContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "unreadNotifications":
            MessageLookupByLibrary.simpleMessage("Unread notifications"),
        "yourFeed": MessageLookupByLibrary.simpleMessage("Your feed")
      };
}

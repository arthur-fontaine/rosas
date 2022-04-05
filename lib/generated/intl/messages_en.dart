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
        "continueWithoutLoggingIn":
            MessageLookupByLibrary.simpleMessage("Continue without logging in"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "The account already exists for that email."),
        "learnMoreAboutBangs": MessageLookupByLibrary.simpleMessage(
            "Learn more about Rosas Bangs."),
        "logIn": MessageLookupByLibrary.simpleMessage("Log in"),
        "markAllAsRead":
            MessageLookupByLibrary.simpleMessage("Mark all as read"),
        "noEmailError": MessageLookupByLibrary.simpleMessage(
            "You have to provide an email."),
        "noPasswordError": MessageLookupByLibrary.simpleMessage(
            "You have to provide a password."),
        "noSubscription":
            MessageLookupByLibrary.simpleMessage("You have no subscription."),
        "noSubscriptionMessage": MessageLookupByLibrary.simpleMessage(
            "Tap on the search button to subscribe to your favorite media."),
        "notificationsAndReadLater": MessageLookupByLibrary.simpleMessage(
            "Notifications and Read later"),
        "notificationsAndReadLaterDescription":
            MessageLookupByLibrary.simpleMessage(
                "Find your notifications and added articles in the Read Later section on the home page. Rosas will automatically move them to the top."),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsNotSame": MessageLookupByLibrary.simpleMessage(
            "The passwords are not the same."),
        "readLater": MessageLookupByLibrary.simpleMessage("Read later"),
        "readMore": m1,
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchWithBangs":
            MessageLookupByLibrary.simpleMessage("Search with !command"),
        "searchWithBangsDescription": MessageLookupByLibrary.simpleMessage(
            "Search for sources across different services with DuckDuckGo Bangs inspired search."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signUpOrLogin":
            MessageLookupByLibrary.simpleMessage("Sign up or log in."),
        "signUpOrLoginDescription": MessageLookupByLibrary.simpleMessage(
            "Being authenticated allows you to enjoy synchronization between all your devices."),
        "splitReading": MessageLookupByLibrary.simpleMessage("Split reading"),
        "splitReadingDescription": MessageLookupByLibrary.simpleMessage(
            "The main feature of Rosas is the split reading. Instead of reading your articles in a huge block, read them as a Twitter thread, in 280 character chunks."),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Subscribed"),
        "tContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "unknownError": MessageLookupByLibrary.simpleMessage("Unknown error."),
        "unreadNotifications":
            MessageLookupByLibrary.simpleMessage("Unread notifications"),
        "userNotFound": MessageLookupByLibrary.simpleMessage(
            "No user found for that email."),
        "weakPassword": MessageLookupByLibrary.simpleMessage(
            "The password provided is too weak."),
        "wrongPassword": MessageLookupByLibrary.simpleMessage(
            "Wrong password provided for that user."),
        "yourFeed": MessageLookupByLibrary.simpleMessage("Your feed")
      };
}

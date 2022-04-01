import 'package:flutter/material.dart';

class RosasTextField extends TextField {
  final String? placeholder;
  final ThemeData? theme;

  const RosasTextField({Key? key, this.placeholder, this.theme})
      : super(key: key);

  @override
  InputDecoration? get decoration => InputDecoration(
        hintText: placeholder ?? '',
        hintStyle: theme?.textTheme.bodyText1,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: theme != null
                  ? theme!.colorScheme.onBackground
                  : Colors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: theme != null
                  ? theme!.colorScheme.onBackground
                  : Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: theme != null
                  ? theme!.colorScheme.onBackground
                  : Colors.black),
        ),
      );

  @override
  Color? get cursorColor => theme?.colorScheme.secondary;
}

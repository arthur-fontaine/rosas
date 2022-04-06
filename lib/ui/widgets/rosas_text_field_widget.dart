import 'package:flutter/material.dart';

class RosasTextField extends StatelessWidget {
  final String? placeholder;
  final ThemeData? theme;
  final TextEditingController? controller;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final bool password;

  const RosasTextField(
      {Key? key,
      this.placeholder,
      this.theme,
      this.controller,
      this.autofocus,
      this.keyboardType,
      this.password = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: theme?.colorScheme.secondary,
      autofocus: autofocus ?? false,
      obscureText: password,
      enableSuggestions: !password,
      autocorrect: !password,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: placeholder ?? '',
        hintStyle: theme?.textTheme.bodyText1,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: theme != null
                  ? theme!.colorScheme.onBackground
                  : Colors.black),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.only(left: 3, bottom: 6),
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
      ),
    );
  }
}

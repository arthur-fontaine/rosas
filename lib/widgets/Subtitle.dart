import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle(
      {Key key, this.subtitle, this.textStyle, this.overflow, this.textAlign})
      : super(key: key);

  final String subtitle;
  final TextStyle textStyle;
  final TextOverflow overflow;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Text(
        subtitle,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 28.5,
        ).merge(textStyle),
      ),
    );
  }
}

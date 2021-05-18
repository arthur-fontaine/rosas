import 'package:flutter/material.dart';

class SquareCard extends StatelessWidget {
  const SquareCard({Key key, this.background}) : super(key: key);

  final Widget background;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 64.8,
        height: 64.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: background,
        ),
      ),
    );
  }
}

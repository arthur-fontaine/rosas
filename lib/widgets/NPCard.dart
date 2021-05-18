import 'package:flutter/material.dart';

class NPCard extends StatelessWidget {
  const NPCard(
      {Key key,
      @required this.title,
      @required this.background,
      this.contentEncoded,
      this.height,
      this.width,
      this.textPadding,
      this.textStyle})
      : super(key: key);

  final String title;
  final Widget background;
  final String contentEncoded;
  final double height;
  final double width;
  final double textPadding;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 144,
      width: width ?? 108,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomLeft,
          children: [
            background,
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                  stops: [0.17, 1],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(textPadding ?? 5),
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Text(
                  title,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                  ).merge(textStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class XState extends StatelessWidget {
  final Image illustration;
  final String title;
  final String description;
  final Widget? bottom;

  const XState(
      {Key? key,
      required this.illustration,
      required this.title,
      required this.description,
      this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: illustration,
            ),
            const SizedBox(height: 48),
            Column(
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                const SizedBox(height: 8),
                Text(description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                bottom != null ? bottom! : Container(),
              ],
            ),
            // const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }
}

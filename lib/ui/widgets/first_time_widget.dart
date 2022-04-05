import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

class FirstTime extends StatelessWidget {
  final VoidCallback onContinue;

  const FirstTime({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.black.withAlpha(127),
        ),
        Container(
          constraints: BoxConstraints.loose(Size.infinite),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 0,
                child: Column(
                  children: [
                    FirstTimeSection(
                      iconData: Icons.splitscreen_rounded,
                      title: S.of(context).splitReading,
                      description: S.of(context).splitReadingDescription,
                    ),
                    const SizedBox(height: 16),
                    FirstTimeSection(
                      iconData: Icons.notifications_none_rounded,
                      title: S.of(context).notificationsAndReadLater,
                      description:
                          S.of(context).notificationsAndReadLaterDescription,
                    ),
                    const SizedBox(height: 16),
                    FirstTimeSection(
                      iconData: Icons.search_rounded,
                      title: S.of(context).searchWithBangs,
                      description: S.of(context).searchWithBangsDescription,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Flexible(
                fit: FlexFit.loose,
                flex: 0,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: RosasTextButton(
                      text: S.of(context).tContinue,
                      onClick: onContinue,
                      fill: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FirstTimeSection extends StatelessWidget {
  final IconData iconData;
  final String description;
  final String title;

  const FirstTimeSection(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData),
          const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 0,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 0,
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

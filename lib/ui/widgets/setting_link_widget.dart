import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';

class SettingLink extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final String description;
  final bool comingSoon;
  final String? routeName;
  final Function? onTap;

  const SettingLink(
      {Key? key,
      required this.title,
      required this.description,
      this.iconData,
      this.comingSoon = false,
      this.routeName,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName!);
        } else if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconData != null ? Icon(iconData) : Container(),
          iconData != null ? const SizedBox(width: 24) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    children: <TextSpan>[
                      TextSpan(text: title),
                      comingSoon
                          ? TextSpan(
                              text: ' (',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ))
                          : const TextSpan(),
                      comingSoon
                          ? TextSpan(
                              text: S.of(context).comingSoon,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                            )
                          : const TextSpan(text: ' '),
                      comingSoon
                          ? TextSpan(
                              text: ')',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ))
                          : const TextSpan(),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
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

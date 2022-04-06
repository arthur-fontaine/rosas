import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

class SettingsPage extends StatelessWidget {
  static const String route = 'settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        elevation: 0,
        title: Text(S.of(context).settings,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground)),
        centerTitle: false,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SettingLink(
                  iconData: Icons.person_outline_rounded,
                  title: S.of(context).account,
                  description: S.of(context).accountSettingsDescription,
                  routeName: AccountSettingsPage.route,
                ),
                const SizedBox(height: 24),
                SettingLink(
                  iconData: Icons.imagesearch_roller_outlined,
                  title: S.of(context).theme,
                  description: S.of(context).themeSettingsDescription,
                  comingSoon: true,
                ),
                const SizedBox(height: 24),
                SettingLink(
                  iconData: Icons.widgets_outlined,
                  title: S.of(context).integrations,
                  description: S.of(context).integrationsSettingsDescription,
                  comingSoon: true,
                ),
                const SizedBox(height: 24),
                SettingLink(
                  iconData: Icons.info_outline_rounded,
                  title: S.of(context).credits,
                  description: S.of(context).creditsSettingsDescription,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

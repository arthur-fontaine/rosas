import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/setting_link_widget.dart';

class AccountSettingsPage extends StatelessWidget {
  static const String route = 'account_settings';

  const AccountSettingsPage({Key? key}) : super(key: key);

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
        title: Text(S.of(context).account,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground)),
        centerTitle: false,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => Container(
          color: Theme.of(context).colorScheme.background,
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: state.user != null && state.user?.isAnonymous == false
                    ? Column(
                        children: [
                          SettingLink(
                              title: S.of(context).email,
                              description: state.user?.email ?? '',
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CheckPasswordPage.route, arguments:
                                        CheckPasswordPageArguments(
                                            (BuildContext context) {
                                  Navigator.pushReplacementNamed(
                                      context, ChangeEmailPage.route);
                                }));
                              }),
                          const SizedBox(height: 24),
                          SettingLink(
                              title: S.of(context).changePassword,
                              description:
                                  S.of(context).changePasswordDescription,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CheckPasswordPage.route, arguments:
                                        CheckPasswordPageArguments(
                                            (BuildContext context) {
                                  Navigator.pushReplacementNamed(
                                      context, ChangePasswordPage.route);
                                }));
                              }),
                          const SizedBox(height: 24),
                          SettingLink(
                            title: S.of(context).downloadYourData,
                            description:
                                S.of(context).downloadYourDataDescription,
                            comingSoon: true,
                          ),
                          const SizedBox(height: 24),
                          SettingLink(
                              title: S.of(context).deleteYourAccount,
                              description:
                                  S.of(context).deleteYourAccountDescription,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CheckPasswordPage.route, arguments:
                                        CheckPasswordPageArguments(
                                            (BuildContext context) {
                                  Navigator.pushReplacementNamed(
                                      context, DeleteAccountPage.route);
                                }));
                              }),
                          const SizedBox(height: 24),
                          SettingLink(
                            title: S.of(context).logOut,
                            description: '',
                            onTap: () async {
                              await auth.signOut();
                              await auth.signInAnonymously();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SettingLink(
                            title: S.of(context).logIn,
                            description: S.of(context).logInDescription,
                            routeName: LoginPage.route,
                          ),
                          const SizedBox(height: 24),
                          SettingLink(
                            title: S.of(context).signUp,
                            description: S.of(context).signUpDescription,
                            routeName: SignupPage.route,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

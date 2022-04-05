import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

class AuthPage extends StatelessWidget {
  static const String route = 'auth';

  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      XState(
                        illustration:
                            Image.asset('assets/images/auth-illustration.png'),
                        title: S.of(context).signUpOrLogin,
                        description: S.of(context).signUpOrLoginDescription,
                        bottom: Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RosasTextButton(
                                text: S.of(context).logIn,
                                fill: false,
                                onClick: () {
                                  Navigator.pushNamed(context, LoginPage.route);
                                },
                              ),
                              RosasTextButton(
                                text: S.of(context).signUp,
                                fill: true,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, SignupPage.route);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GestureDetector(
                      onTap: () {
                        auth.signInAnonymously();
                        Navigator.pushReplacementNamed(context, HomePage.route);
                      },
                      child: Text(
                        S.of(context).continueWithoutLoggingIn,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 14,
                              height: 1,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

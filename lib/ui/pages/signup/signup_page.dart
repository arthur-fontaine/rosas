import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/pages/home/home_page.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:rosas/utils/util_barrel.dart';

class SignupPage extends StatefulWidget {
  static const String route = 'sign_up';

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  String? error;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  void signup() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text) {
      setState(() {
        error = null;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        final user = userCredential.user;

        if (user != null) {
          initUser(user);
        }

        Navigator.pushReplacementNamed(context, HomePage.route);
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            error = S.of(context).weakPassword;
          } else if (e.code == 'email-already-in-use') {
            error = S.of(context).emailAlreadyInUse;
          }
        });
      } catch (e) {
        error = S.of(context).unknownError;
      }
    } else {
      setState(() {
        if (_passwordController.text != _confirmPasswordController.text) {
          error = S.of(context).passwordsNotSame;
        } else if (_emailController.text.isEmpty) {
          error = S.of(context).noEmailError;
        } else if (_passwordController.text.isEmpty) {
          error = S.of(context).noPasswordError;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Text(
          S.of(context).signUp,
          style: Theme.of(context).textTheme.headline2?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RosasTextField(
                  placeholder: S.of(context).email,
                  theme: Theme.of(context),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController),
              const SizedBox(height: 16),
              RosasTextField(
                  placeholder: S.of(context).password,
                  theme: Theme.of(context),
                  password: true,
                  controller: _passwordController),
              const SizedBox(height: 16),
              RosasTextField(
                  placeholder: 'Confirm password',
                  theme: Theme.of(context),
                  password: true,
                  controller: _confirmPasswordController),
              SizedBox(height: error != null ? 16 : 0),
              error != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error,
                            color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(error!),
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 32),
              RosasTextButton(
                  text: S.of(context).signUp, fill: true, onClick: signup),
            ],
          ),
        ),
      ),
    );
  }
}

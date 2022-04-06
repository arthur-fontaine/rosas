import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/pages/home/home_page.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:rosas/utils/util_barrel.dart';

class LoginPage extends StatefulWidget {
  static const String route = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? error;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    if (!(_emailController.text.isEmpty || _passwordController.text.isEmpty)) {
      setState(() {
        error = null;
      });

      try {
        final userCredential = await auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        final user = userCredential.user;

        if (user != null) {
          fetchFromCloud(context, user);
        }

        Navigator.pushReplacementNamed(context, HomePage.route);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            error = S.of(context).userNotFound;
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            error = S.of(context).wrongPassword;
          });
        }
      }
    } else {
      setState(() {
        if (_emailController.text.isEmpty) {
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
          S.of(context).logIn,
          style: Theme.of(context).textTheme.headline1?.copyWith(
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
                  text: S.of(context).logIn, fill: true, onClick: login),
            ],
          ),
        ),
      ),
    );
  }
}

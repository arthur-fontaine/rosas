import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/widgets/rosas_text_button_widget.dart';
import 'package:rosas/ui/widgets/rosas_text_field_widget.dart';
import 'package:rosas/utils/util_barrel.dart';

class CheckPasswordPageArguments {
  final Function(BuildContext) callback;

  CheckPasswordPageArguments(this.callback);
}

class CheckPasswordPage extends StatefulWidget {
  static const String route = 'check_password';

  final Function(BuildContext) callback;

  const CheckPasswordPage({Key? key, required this.callback}) : super(key: key);

  @override
  State<CheckPasswordPage> createState() => _CheckPasswordPageState();
}

class _CheckPasswordPageState extends State<CheckPasswordPage> {
  late final TextEditingController _passwordController;
  String? error;

  @override
  void initState() {
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final user = authBloc.state.user;

    if (user == null) {
      Navigator.pop(context);
      throw 'User is null';
    }

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
        title: Text(S.of(context).verifyPassword,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground)),
        centerTitle: false,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RosasTextField(
                      placeholder: S.of(context).password,
                      theme: Theme.of(context),
                      controller: _passwordController,
                      autofocus: true,
                      password: true),
                  error != null ? const SizedBox(height: 16) : Container(),
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
                  const SizedBox(height: 24),
                  RosasTextButton(
                      text: S.of(context).tContinue,
                      fill: true,
                      onClick: () async {
                        if (await checkPassword(
                            user, _passwordController.text)) {
                          widget.callback(context);
                        } else {
                          setState(() {
                            error = S.of(context).wrongPassword;
                          });
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

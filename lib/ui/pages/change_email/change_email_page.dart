import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/ui/widgets/rosas_text_button_widget.dart';
import 'package:rosas/ui/widgets/rosas_text_field_widget.dart';

class ChangeEmailPage extends StatefulWidget {
  static const String route = 'change_email';

  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  late final TextEditingController _emailController;
  String? error;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
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

    if (user.email != null) {
      _emailController.text = user.email!;
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
        title: Text(S.of(context).email,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RosasTextField(
                    placeholder: S.of(context).email,
                    theme: Theme.of(context),
                    controller: _emailController,
                    autofocus: false),
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
                    text: S.of(context).changeEmail,
                    fill: true,
                    onClick: () async {
                      try {
                        await user.updateEmail(_emailController.text);
                      } catch (e) {
                        setState(() {
                          error = S.of(context).unknownError;
                        });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

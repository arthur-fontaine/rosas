import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/ui/widgets/rosas_text_button_widget.dart';

class DeleteAccountPage extends StatefulWidget {
  static const String route = 'delete_account';

  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  String? error;

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
        title: Text(S.of(context).deleteYourAccount,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).deleteAccountDisclaimer,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
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
                      text: S.of(context).deleteYourAccount,
                      fill: true,
                      onClick: () async {
                        try {
                          await users.doc(user.uid).delete();
                          await user.delete();
                          await auth.signInAnonymously();
                          Navigator.pop(context);
                        } catch (e) {
                          setState(() {
                            error = S.of(context).unknownError;
                          });
                          rethrow;
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

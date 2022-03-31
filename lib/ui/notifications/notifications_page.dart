import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/notifications/notifications_layout.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/notifications_barrel.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NotificationsBloc>(
        create: (context) => NotificationsBloc(
            notificationsRepository: context.read<NotificationsRepository>(),
            feedsRepository: context.read<FeedsRepository>())
          ..add(GetNotifications()),
        child: const NotificationsLayout(),
      ),
    );
  }
}

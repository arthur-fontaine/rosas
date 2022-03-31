import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/bloc/notifications_bloc.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/notifications_widget.dart';

class NotificationsLayout extends StatelessWidget {
  const NotificationsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationBloc = context.read<NotificationsBloc>();

    notificationBloc.add(OpenNotificationsPage());

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      notificationBloc.add(GetNotifications());

                      while (!notificationBloc.state.status.isLoading) {
                        await Future.delayed(const Duration(milliseconds: 100));
                      }
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    child: const SingleChildScrollView(
                      child: Notifications(),
                      physics: ClampingScrollPhysics(),
                    ),
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

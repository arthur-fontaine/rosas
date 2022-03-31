import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rosas/ui/home/widgets/news_widget/news_barrel.dart';
import 'package:rosas/ui/home/widgets/home_widgets_barrel.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final repository = context.read<NewsBloc>();
                repository.add(GetSubscribedNews());

                while (!repository.state.status.isLoading) {
                  await Future.delayed(const Duration(milliseconds: 100));
                }
              },
              color: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: const SingleChildScrollView(
                child: News(),
                physics: ClampingScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

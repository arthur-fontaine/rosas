import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/repositories/feeds_repository.dart';
import 'package:rosas/ui/home/home_layout.dart';
import 'package:rosas/ui/home/widgets/news_widget/bloc/news_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NewsBloc>(
        create: (context) =>
            NewsBloc(feedsRepository: context.read<FeedsRepository>())
              ..add(GetSubscribedNews()),
        child: const HomeLayout(),
      ),
    );
  }
}

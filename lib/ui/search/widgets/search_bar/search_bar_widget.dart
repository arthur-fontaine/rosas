import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:rosas/ui/search/widgets/search_bar/bloc/search_bar_bloc.dart';

class SearchBar extends StatelessWidget {
  final _controller = TextEditingController();

  SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchBarBloc = context.read<SearchBarBloc>();

    _controller.addListener(() {
      _searchBarBloc.add(SetSearchTerm(searchTerm: _controller.text));
    });

    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Search feed',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    _controller.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _controller.text = '';
                            },
                            icon: const HeroIcon(HeroIcons.x))
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

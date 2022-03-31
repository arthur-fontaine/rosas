import 'package:flutter/material.dart';

import 'package:rosas/themes/themes_barrel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border:
            Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rosas",
              style: CustomTextStyles.h1,
            ),
            Image.asset(
              'assets/images/flower-colored.png',
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

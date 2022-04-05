import 'package:flutter/material.dart';

class RosasTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final bool fill;

  const RosasTextButton({Key? key, required this.text, this.onClick, this.fill = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick ?? () {},
      child: Container(
        child: Text(text, style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: fill ? FontWeight.w500 : null,
          color: fill ? Colors.white : Theme.of(context).colorScheme.onBackground,
          height: 1,
        )),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: fill ? Theme.of(context).colorScheme.onBackground : null,
          border: Border.all(color: Theme.of(context).colorScheme.onBackground, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    );
  }
}

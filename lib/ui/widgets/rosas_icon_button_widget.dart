import 'package:flutter/material.dart';

class RosasIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onClick;
  final bool fill;

  const RosasIconButton({Key? key, required this.iconData, this.onClick, this.fill = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick ?? () {},
      child: Container(
        child: GestureDetector(
          onTap: onClick,
          child: Icon(iconData, color: fill ? Colors.white : Theme.of(context).colorScheme.onBackground, size: 18),
        ),
          padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: fill ? Theme.of(context).colorScheme.onBackground : null,
          border: Border.all(
              color: Theme.of(context).colorScheme.onBackground,
              width: 1,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DescTextButton extends StatelessWidget {
  const DescTextButton({
    super.key,
    required this.text,
    this.onTap,
    required this.button,
  });
  final String text;
  final Function()? onTap;
  final bool button;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      button
          ? TextButton(onPressed: onTap, child: const Text('View all'))
          : Container(),
    ]);
  }
}

import 'package:flutter/material.dart';

class QuantitySelect extends StatelessWidget {
  const QuantitySelect({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });
  final int quantity;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.remove,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(child: Text(quantity.toString())),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

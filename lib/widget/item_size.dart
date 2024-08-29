import 'package:eco_app/models/size_item.dart';
import 'package:flutter/material.dart';

class ItemSize extends StatelessWidget {
  const ItemSize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items Size',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            constraints: const BoxConstraints(maxHeight: 40),
            child: const ListSizeOption())
      ],
    );
  }
}

class ListSizeOption extends StatefulWidget {
  const ListSizeOption({super.key});

  @override
  State<ListSizeOption> createState() => _ListSizeOptionState();
}

class _ListSizeOptionState extends State<ListSizeOption> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: SizeCategory.values.length,
      itemBuilder: (BuildContext context, int index) {
        final category = SizeCategory.values[index];
        final numValue = sizeCategoryToNumericValue[category];

        return Container(
            width: 40,
            decoration: BoxDecoration(
                color: index == 0
                    ? Theme.of(context).colorScheme.inversePrimary
                    : Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(
              numValue.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: index == 0
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.inversePrimary,
              ),
            )));
      },
    );
  }
}

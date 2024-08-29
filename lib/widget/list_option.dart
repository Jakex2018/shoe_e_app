import 'package:eco_app/models/brands.dart';
import 'package:flutter/material.dart';

class ListOption extends StatefulWidget {
  final Function(BrandCategory?) onCategorySelect;

  const ListOption({
    required this.onCategorySelect,
    super.key,
  });

  @override
  State<ListOption> createState() => _ListOptionState();
}

class _ListOptionState extends State<ListOption> {
  BrandCategory? selectedCategory = BrandCategory.all;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCategoryOption(BrandCategory.all, 'All'),
        const SizedBox(
          width: 10,
        ),
        _buildCategoryOption(BrandCategory.man, 'Men'),
        const SizedBox(
          width: 10,
        ),
        _buildCategoryOption(BrandCategory.woman, 'Women')
      ],
    );
  }

  Widget _buildCategoryOption(BrandCategory category, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category
              ? Theme.of(context).colorScheme.inversePrimary
              : Theme.of(context).colorScheme.secondary),
      onPressed: () {
        setState(() {
          selectedCategory = category;
          widget.onCategorySelect(category);
        });
      },
      child: Text(
        text,
        style: TextStyle(
            color: selectedCategory == category
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}

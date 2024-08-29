import 'package:flutter/material.dart';

class BrandImage extends StatelessWidget {
  const BrandImage({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary, width: 3),
              color: Theme.of(context).colorScheme.primary.withOpacity(.4),
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Center(
              child: Image.asset(
            image,
            color: Theme.of(context).colorScheme.inversePrimary,
            fit: BoxFit.contain,
            height: 18,
          )),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        )
      ],
    );
  }
}

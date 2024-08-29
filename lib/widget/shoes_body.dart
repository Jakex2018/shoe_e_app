import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/widget/item_size.dart';
import 'package:flutter/material.dart';

class ShoesBody extends StatelessWidget {
  const ShoesBody({
    super.key,
    required this.arrival,
  });
  final Arrival arrival;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.surface,
            child: Image(
              image: AssetImage(arrival.image),
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                arrival.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              const ItemSize(),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                arrival.desc,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 13,
                    wordSpacing: 3),
              )
            ],
          ),
        )
      ],
    ));
  }
}

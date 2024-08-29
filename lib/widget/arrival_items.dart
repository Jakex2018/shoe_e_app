import 'package:eco_app/models/arrival.dart';
import 'package:flutter/material.dart';

class ArrivalItems extends StatelessWidget {
  const ArrivalItems({
    super.key,
    this.onTap,
    required this.arrival,
  });
  final Arrival arrival;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .43,
        height: 276,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width * .43,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(14)),
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, right: 10),
                    child: Image(
                      image: AssetImage(arrival.image),
                      fit: BoxFit.fill,
                    ),
                  )),
              Positioned(
                  top: 0,
                  left: 10,
                  child: Container(
                      height: 70,
                      width: 27,
                      decoration: BoxDecoration(
                          color: arrival.prom == 0.3 || arrival.prom == 0.5
                              ? Theme.of(context).colorScheme.inversePrimary
                              : arrival.prom == 0.7
                                  ? Colors.red
                                  : null,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Center(
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "${arrival.prom}% OFF",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold),
                            )),
                      )))
            ]),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 130,
              child: Text(
                arrival.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${arrival.price}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 15,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

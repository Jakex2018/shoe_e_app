import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/widget/icon_text_button.dart';
import 'package:eco_app/widget/shoes_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoesPage extends StatefulWidget {
  const ShoesPage({
    super.key,
    required this.arrival,
  });

  final Arrival arrival;

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      body: ShoesBody(arrival: widget.arrival),
      bottomNavigationBar: bottomNav(context),
    );
  }

  Container bottomNav(BuildContext context) {
    void addCart(Arrival arrival) {
      Navigator.pop(context);
      var snackbar = const SnackBar(
        content: Text(
          'Products added to the cart',
          style: TextStyle(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 50, left: 60, right: 50),
        backgroundColor: Color.fromARGB(255, 12, 165, 53),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      context.read<ArrivalProvider>().addToCart(arrival);
    }

    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: BorderDirectional(
                top: BorderSide(
                    color: Theme.of(context).colorScheme.surface, width: 2))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '\$${widget.arrival.price}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: IconTextButton(
                    title: 'Add to Cart',
                    icon: Icons.shopify_rounded,
                    onTap: () => addCart(widget.arrival),
                  ),
                )
              ],
            )
          ]),
        ));
  }
}

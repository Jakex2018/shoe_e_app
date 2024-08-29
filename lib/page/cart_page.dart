import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/page/payment_page.dart';
import 'package:eco_app/widget/button_one.dart';
import 'package:eco_app/widget/cart_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArrivalProvider>(
      builder: (context, arrival, child) {
        final userCart = arrival.cart;
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: cartAppBar(context, arrival),
          body: userCart.isEmpty
              ? Center(
                  child: Text(
                  'Cart is Empty...',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: cartInfo(context, arrival),
                    ),
                    Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return CartTile(
                            cartItem: cartItem,
                          );
                        },
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.secondary,
              child: Center(
                  child: ButtonOne(
                onTap: () {
                  arrival.getTotalArrival() == 0
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Not Found Products in the cart'),
                            actions: [
                              MaterialButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              arriva: arrival.getTotalPrice(),
                              quantity: arrival.getTotalArrival(),
                              desc: arrival
                                  .displayCartReceipt(arrival.getTotalPrice()),
                            ),
                          ));
                },
                title: 'Proceed to Buy (${arrival.getTotalArrival()} Items)',
              ))),
        );
      },
    );
  }

  Widget cartInfo(BuildContext context, ArrivalProvider arrival) {
    return Column(
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'Subtotal',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  children: [
                    const TextSpan(text: '  '),
                    TextSpan(
                      text: '\$${arrival.getTotalPrice()}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Your order is eligible for free Delivery',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ],
    );
  }

  AppBar cartAppBar(BuildContext context, ArrivalProvider arrival) {
    void showCustomSnackBar(BuildContext context, String message) {
      var snackbar = SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.only(bottom: 50, left: 60, right: 50),
        backgroundColor: const Color.fromARGB(255, 12, 165, 53),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      arrival.clearCart();
    }

    return AppBar(
      title: const Text('Cart'),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:
                      const Text('Are you sure you want delete this product'),
                  actions: [
                    MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showCustomSnackBar(
                            context, 'Delete products to the Cart');
                      },
                      child: const Text("Delete"),
                    )
                  ],
                ),
              );
            },
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/models/cart.dart';
import 'package:eco_app/widget/icon_text_button.dart';
import 'package:eco_app/widget/quantity_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cartItem,
  });
  final Cart cartItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<ArrivalProvider>(
      builder: (context, arrival, child) {
        void remoteToCart(Cart cartItem) {
          arrival.removeAllArrival(cartItem);
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * .93,
              height: 160,
              margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(cartItem.arrival.image),
                    height: 120,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 160,
                          child: Text(
                            cartItem.arrival.name,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('\$${cartItem.arrival.price.toString()}'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'FREE Delivery',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          QuantitySelect(
                            quantity: cartItem.quantity,
                            onIncrement: () {
                              arrival.addToCart(cartItem.arrival);
                            },
                            onDecrement: () {
                              arrival.removeToCart(cartItem);
                            },
                          ),
                          IconTextButton(
                              onTap: () => remoteToCart(cartItem),
                              title: 'Remove',
                              icon: Icons.delete)
                        ],
                      )
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}

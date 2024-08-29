import 'package:eco_app/models/order.dart';
import 'package:eco_app/page/home_page.dart';
import 'package:eco_app/widget/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        void showCustomSnackBar(BuildContext context, String message) {
          var snackbar = SnackBar(
            content: Text(message, style: const TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            margin: const EdgeInsets.only(bottom: 50, left: 60, right: 50),
            backgroundColor: const Color.fromARGB(255, 12, 165, 53),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          order.clearOrder();
        }

        final orderList = order.orders;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Orders'),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: const Icon(Icons.arrow_back_rounded)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                            'Are you sure you want delete all orders'),
                        actions: [
                          MaterialButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showCustomSnackBar(context, 'Deleted Orders');
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
          ),
          body: orderList.isEmpty
              ? Center(
                  child: Text(
                  'ORDERS is Empty...',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          itemCount: orderList.length,
                          onPageChanged: (int index) =>
                              setState(() => currentPage = index),
                          itemBuilder: (context, index) {
                            final orderItem = orderList[index];
                            return OrderTile(
                              order: orderItem,
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          orderList.length,
                          (index) => Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}

import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/page/home_page.dart';
import 'package:eco_app/page/order_page.dart';
import 'package:eco_app/widget/button_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Payment'),
        
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: const SingleChildScrollView(child: Ticket()),
    );
  }
}

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Thank you for your order',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .8,
                child: Consumer<ArrivalProvider>(
                    builder: (context, arrival, child) => Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Center(
                              child: Text(
                            arrival.displayCartReceipt(arrival.getTotalPrice()),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          )),
                        )),
              ),
              const SizedBox(
                height: 70,
              ),
              Column(
                children: [
                  ButtonOne(
                    title: 'Go to Home',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonOne(
                    title: 'My orders',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                          ));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

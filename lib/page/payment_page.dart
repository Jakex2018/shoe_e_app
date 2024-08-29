import 'package:eco_app/models/order.dart';
import 'package:eco_app/page/delivery_page.dart';
import 'package:eco_app/widget/button_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.arriva,
      required this.quantity,
      required this.desc});
  final int arriva;
  final int quantity;
  final String desc;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    void userPayment() {
      if (formKey.currentState!.validate()) {
        final order = Order(
            id: UniqueKey().toString(),
            quantity: widget.quantity,
            product: widget.desc,
            date: DateTime.now(),
            totalAmount: widget.arriva);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm payment"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Card Number:$cardNumber"),
                  Text("Expiry Date:$expiryDate"),
                  Text("Card Holder name:$cardHolderName"),
                  Text("CVV:$cvvCode")
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<OrderProvider>().addOrder(order);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeliveryPage(),
                        ));
                  },
                  child: const Text('Yes'))
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (item) {},
            ),
            CreditCardForm(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (item) {
                  setState(() {
                    cardNumber = item.cardNumber;
                    expiryDate = item.expiryDate;
                    cardHolderName = item.cardHolderName;
                    cvvCode = item.cvvCode;
                  });
                },
                cvvValidationMessage: 'Please input a valid CVV',
                dateValidationMessage: 'Please input a valid date',
                numberValidationMessage: 'Please input a valid number',
                obscureCvv: true,
                inputConfiguration: InputConfiguration(
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                  cardNumberTextStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  cardHolderTextStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  expiryDateTextStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  cvvCodeTextStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                formKey: formKey),
            const SizedBox(
              height: 80,
            ),
            ButtonOne(
              title: 'Pay Now',
              onTap: () => userPayment(),
            ),
          ],
        ),
      ),
    );
  }
}

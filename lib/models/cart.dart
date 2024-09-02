import 'package:eco_app/models/arrival.dart';

class Cart {
  final Arrival arrival;
  int quantity;
  int totalPrice = 0;

  Cart({required this.arrival, this.quantity = 1}) {
    totalPrice = arrival.price * quantity;
  }
}

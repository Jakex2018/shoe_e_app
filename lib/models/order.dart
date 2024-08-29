import 'package:flutter/material.dart';

class Order {
  final String id;
  final DateTime date;
  final String product;
  final int totalAmount;
  final int quantity;
  Order(
      {required this.product,
      required this.quantity,
      required this.id,
      required this.date,
      required this.totalAmount});
}

class OrderProvider extends ChangeNotifier {
  List<Order> orders = [];
  void addOrder(Order order) {
    orders.add(order);
    notifyListeners();
  }

  void clearOrder() {
    orders.clear();
    notifyListeners();
  }
}

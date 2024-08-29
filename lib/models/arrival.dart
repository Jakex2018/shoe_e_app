// ignore_for_file: constant_identifier_names
import 'package:collection/collection.dart';
import 'package:eco_app/models/brands.dart';
import 'package:eco_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Arrival extends ChangeNotifier {
  final String name;
  final int price;
  final String image;
  final double prom;
  final String desc;
  final BrandCategory? cat;
  final int id;
  Arrival(
      {required this.prom,
      required this.id,
      required this.cat,
      required this.desc,
      required this.price,
      required this.name,
      required this.image});
}

class ArrivalProvider extends ChangeNotifier {
  final List<Arrival> menu = [
    Arrival(
        id: 1,
        prom: double.parse('0.3'),
        name: 'Nike Air Force 1 Pixel',
        image: 'asset/shoe03.png',
        cat: BrandCategory.man,
        price: 199,
        desc:
            "Keep the game going in the shoe that launched a movement, our Future Rider Play On Unisex Sneakers. This shoe is dedicated to pared-down performance, featuring a super-light nylon, suede and leather upper and our famous shock-absorbing Federbein outsole to keep you pounding the pavement in style."),
    Arrival(
        id: 2,
        prom: double.parse('0'),
        name: 'Wild Rider Layers Unisex Sneakers',
        image: 'asset/shoe04.png',
        price: 250,
        cat: BrandCategory.woman ,
        desc:
            "Keep the game going in the shoe that launched a movement, our Future Rider Play On Unisex Sneakers. This shoe is dedicated to pared-down performance, featuring a super-light nylon, suede and leather upper and our famous shock-absorbing Federbein outsole to keep you pounding the pavement in style."),
    Arrival(
        id: 2,
        prom: double.parse('0'),
        name: 'Wild Rider Layers Unisex Sneakers',
        image: 'asset/shoe04.png',
        price: 250,
        cat: BrandCategory.woman,
        desc:
            "Keep the game going in the shoe that launched a movement, our Future Rider Play On Unisex Sneakers. This shoe is dedicated to pared-down performance, featuring a super-light nylon, suede and leather upper and our famous shock-absorbing Federbein outsole to keep you pounding the pavement in style."),
    Arrival(
        id: 2,
        prom: double.parse('0'),
        name: 'Wild Rider Layers Unisex Sneakers',
        image: 'asset/shoe04.png',
        price: 250,
        cat: BrandCategory.woman,
        desc:
            "Keep the game going in the shoe that launched a movement, our Future Rider Play On Unisex Sneakers. This shoe is dedicated to pared-down performance, featuring a super-light nylon, suede and leather upper and our famous shock-absorbing Federbein outsole to keep you pounding the pavement in style."),
    Arrival(
        id: 2,
        prom: double.parse('0'),
        name: 'Wild Rider Layers Unisex Sneakers',
        image: 'asset/shoe04.png',
        price: 250,
        cat:  BrandCategory.woman,
        desc:
            "Keep the game going in the shoe that launched a movement, our Future Rider Play On Unisex Sneakers. This shoe is dedicated to pared-down performance, featuring a super-light nylon, suede and leather upper and our famous shock-absorbing Federbein outsole to keep you pounding the pavement in style."),
  ];

  //USER CART
  // ignore: prefer_final_fields
  List<Cart> _cart = [];

  //GET SHOES
  List<Cart> get cart => _cart;

  //ADD TO CART
  void addToCart(Arrival arrival) {
    Cart? cartItem = _cart.firstWhereOrNull((item) {
      bool sameArrival = item.arrival == arrival;
      return sameArrival;
    });
    cartItem != null ? cartItem.quantity++ : _cart.add(Cart(arrival: arrival));
    notifyListeners();
  }

  //REMOVE TO CART
  void removeToCart(Cart cartItem) {
    int cartId = _cart.indexOf(cartItem);
    if (cartId != -1) {
      if (_cart[cartId].quantity > 1) {
        _cart[cartId].quantity--;
      }
    } else {
      _cart.removeAt(cartId);
    }
    notifyListeners();
  }

  void removeAllArrival(Cart cartItem) {
    int cartId = _cart.indexOf(cartItem);
    if (cartId != -1) {
      _cart.removeAt(cartId);
      notifyListeners();
    }
  }

  //CLEAR TO CART
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //GET TOTAL PRICE OF CART
  int getTotalPrice() {
    int total = 0;
    for (Cart cartItem in _cart) {
      int itemTotal = cartItem.arrival.price * cartItem.quantity;
      total += itemTotal;
    }

    return total;
  }

  //GET TOTAL ARRIVAL OF CART
  int getTotalArrival() {
    int total = 0;
    for (Cart cartItem in _cart) {
      total += cartItem.quantity;
    }
    return total;
  }

  String displayCartReceipt(int arrival) {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();
    String formattedDate =
        DateFormat('yyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln('-----------------');

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity}x ${cartItem.arrival.name}-\$${cartItem.arrival.price}");

      receipt.writeln();
    }
    receipt.writeln();
    receipt.writeln("TOTAL PRICE:                         \$$arrival");
    return receipt.toString();
  }
}

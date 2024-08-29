// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Brands {
  final String name;
  final String image;

  Brands({required this.name, required this.image});
}

class CategoryProvider extends ChangeNotifier {
  final List<Brands> menu = [
    Brands(name: 'Nike', image: 'asset/brand01.png'),
    Brands(name: 'Adidas', image: 'asset/adidas.png'),
    Brands(name: 'Reebok', image: 'asset/reebok.png'),
    Brands(name: 'Puma', image: 'asset/puma.png'),
    Brands(name: 'Jordan', image: 'asset/jordan.png')
  ];
}

enum BrandCategory { all, man, woman }

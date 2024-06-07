import 'package:flutter/material.dart';

class Fruit {
  const Fruit(
      {required this.name,
      required this.image,
      required this.sciName,
      required this.benefits,
      required this.origin,
      required this.inIndia,
      required this.bgColor,
      });
  final String name;
  final String image;
  final String sciName;
  final String benefits;
  final String origin;
  final String inIndia;
  final Color bgColor;
}

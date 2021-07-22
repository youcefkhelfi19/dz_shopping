import 'package:flutter/material.dart';

class Wish extends ChangeNotifier{
  final String id ;
  final String title;
  final double price;
  final String imageUrl;

  Wish({this.id, this.title, this.price, this.imageUrl});

}
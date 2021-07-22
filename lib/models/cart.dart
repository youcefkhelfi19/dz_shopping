import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier{
  final String id ;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  Cart({this.id,@required this.productId, this.title, this.quantity, this.price, this.imageUrl});

}
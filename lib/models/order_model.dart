import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Order extends ChangeNotifier {
  final String title ;
  final String orderId;
  final String imageUrl;
  final String userId;
  final double price;
  final int quantity;
  final Timestamp orderDate;
 Order({this.price,this.userId,this.orderDate,this.imageUrl,this.title,this.quantity,this.orderId});
}
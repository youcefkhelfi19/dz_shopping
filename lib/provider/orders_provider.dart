import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Order> _orders=[];
  List<Order>get orders => _orders;
  Future<void> fetchOrders() async {
    User _user = _auth.currentUser;
    var _uid = _user.uid;
  try{
    await FirebaseFirestore.instance
        .collection('Orders').where('userId', isEqualTo: _uid)
        .get()
        .then((QuerySnapshot snapshot) => {
      _orders.clear(),
      snapshot.docs.forEach((element) {
        _orders.insert(
            0,
            Order(
                orderId: element.get('orderId'),
                price: element.get('price'),
                title: element.get('title'),
                imageUrl: element.get('imageUrl'),
                quantity: element.get('quantity'),
                orderDate: element.get('orderDate'),
                userId: element.get('userId')
            ));
      })
    });
  }catch (error){
    print('order $error');
  }
    notifyListeners();
  }
  Future<void>deleteOrder (String orderId)async{
    try{
      await FirebaseFirestore.instance.collection('Orders').doc(orderId).delete();
    }catch (error){
      print('delete Order $error');
    }

  }
  Future<void>deleteOrders()async{
    try{

    }catch (error){

    }
  }
}
import 'package:dz_shopping/models/cart.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{
  Map<String, Cart> _cartItems = {};
  Map<String, Cart> get cartItems {
    return _cartItems;
  }
  double get totalAmount{
    var total = 0.0;
     _cartItems.forEach((key, value) {total+= value.price*value.quantity;});
     return total;
  }
  void addProductToCart(String title, String imageUrl,double price,String productId){
    if(_cartItems.containsKey(productId)){
      _cartItems.update(productId, (existingItem)=>Cart(
        id : existingItem.id,
        productId: existingItem.productId,
        title : existingItem.title,
        imageUrl :existingItem.imageUrl,
        price : existingItem.price,
        quantity: existingItem.quantity+1,

      ));
    }else{
      _cartItems.putIfAbsent(productId, () =>Cart(
        id : DateTime.now().toString(),
        productId: productId,
        title : title,
        imageUrl : imageUrl,
        price : price,
        quantity: 1,

      ));
    }
    notifyListeners();
  }
  void reduceProductFromCart(String productId){
    if(_cartItems.containsKey(productId)){
      _cartItems.update(productId, (existingItem)=>Cart(
        id : existingItem.id,
        productId: existingItem.productId,
        title : existingItem.title,
        imageUrl :existingItem.imageUrl,
        price : existingItem.price,
        quantity: existingItem.quantity-1,

      ));
    }
    notifyListeners();
  }
  void removeItem(String id){
    _cartItems.remove(id);
    notifyListeners();
  }
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }

}
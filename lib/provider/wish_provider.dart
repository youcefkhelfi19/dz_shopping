import 'package:dz_shopping/models/wish_model.dart';
import 'package:flutter/cupertino.dart';

class WishProvider extends ChangeNotifier{
  Map<String, Wish> _wishItems = {};
  Map<String, Wish> get wishItems {
    return _wishItems;
  }

  void addProductToWishList(String title, String imageUrl,double price,String productId){
    if(_wishItems.containsKey(productId)){
      removeItem(productId);
      print('removed');
    }else{
        _wishItems.putIfAbsent(productId, () =>Wish(
          id: DateTime.now().toString(),
          title: title,
          imageUrl: imageUrl,
          price: price,


        )

        );
        print('added');
    }
    notifyListeners();
  }

  void removeItem(String id){
    _wishItems.remove(id);
    notifyListeners();
  }
  void clearCart(){
    _wishItems.clear();
    notifyListeners();
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/models/product.dart';
import 'package:flutter/cupertino.dart';

class Products extends ChangeNotifier {
  List<Product> _products=[];
  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot snapshot) => {
         _products=[],
      snapshot.docs.forEach((element) {
        _products.insert(
            0,
            Product(
              id: element.get('id'),
              title: element.get('productName'),
              description: element.get('description'),
              brand: element.get('brand'),
              price: double.parse(element.get('price')),
              quantity: int.parse(element.get('quantity')),
              productCategoryName: element.get('productCategory'),
              imageUrl: element.get('imageUrl'),
              isNew: true,
              isPopular: true,
              isFavorite:false,
            ));
      })
    });
  }
  List<Product> get products {
    return _products;
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  List<Product> findByCategory(String categoryName) {
    List _productsList = _products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _productsList;
  }

  List<Product> findByBrand(String brandName) {
    List _productsList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _productsList;
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> searchQuery(String searchText) {
    List _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}

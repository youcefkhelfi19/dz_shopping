import 'package:badges/badges.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/models/product.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/wish_list.dart';
import 'package:dz_shopping/widgets/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feeds extends StatelessWidget {
  static String routeName = '/Feeds';
  static  String appbarTitle = 'Feeds';

  @override
  Widget build(BuildContext context) {
    final String popular = ModalRoute.of(context).settings.arguments as String;
    final  products = Provider.of<Products>(context,listen: false);
    List<Product> productsList  = products.products;
    if(popular == 'popular'){
      productsList = products.popularProducts;
    }
    return Scaffold(
       appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Feeds",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            leading: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            actions: <Widget>[
              Consumer<WishProvider>(builder: (context, wish, child) {
                return Badge(
                  badgeColor: Colors.red,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 5.0, end: 7.0),
                  badgeContent: Text(
                    '${wish.wishItems.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite,
                        color: Colors.white, size: 30.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishList()));
                    },
                  ),
                );
              }),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Badge(
                    badgeColor: Colors.red,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 5.0, end: 7.0),
                    badgeContent: Text(
                      '${cart.cartItems.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(
                        AppIcons.cart,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cart()));
                      },
                    ),
                  );
                },
              ),
            ]),
      body: GridView.count(crossAxisCount: 2,
      childAspectRatio: 0.7,
      children: List.generate(productsList.length, (index){
        return ChangeNotifierProvider.value(
         value: productsList[index],
          child: FeedsProduct(),
        );
      })
      )
    );
  }
}

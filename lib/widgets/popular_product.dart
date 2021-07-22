import 'package:badges/badges.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/models/product.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productAtt = Provider.of<Product>(context,listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishProvider = Provider.of<WishProvider>(context);

    return InkWell(
      onTap: (){
          Navigator.pushNamed(context, ProductDetails.routeName,arguments: productAtt.id);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          productAtt.imageUrl),
                    )),
              ),
              Positioned(
                top: 5.0,
                right: 5.0,
                child: InkWell(
                  onTap: (){
                    wishProvider.addProductToWishList(productAtt.title, productAtt.imageUrl, productAtt.price, productAtt.id);
                  },
                  child: Badge(
                    toAnimate: false,
                    shape: BadgeShape.square,
                    badgeColor: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    badgeContent: wishProvider.wishItems.containsKey(productAtt.id)?Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ):Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5.0,
                left: 5.0,
                child: Badge(
                  toAnimate: false,
                  shape: BadgeShape.square,
                  badgeColor: AppColors.primaryColor,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10.0)),
                  badgeContent: Text(
                    '${productAtt.price}',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productAtt.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    InkWell(
                      child: cartProvider.cartItems.containsKey(productAtt.id)?Icon(Icons.check_circle_outline,color: Colors.orange,):
                      Icon(Icons.add_shopping_cart,color: Colors.orange,),
                      onTap: cartProvider.cartItems.containsKey(productAtt.id)?null:() {
                        cartProvider.addProductToCart(productAtt.title, productAtt.imageUrl, productAtt.price, productAtt.id);
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(productAtt.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

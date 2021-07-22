import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/wish_list.dart';
import 'package:dz_shopping/widgets/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey previewContainer = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);

    final productId = ModalRoute.of(context).settings.arguments as String;
    final productById = products.findById(productId);
    final suggestedProducts =
        products.findByCategory(productById.productCategoryName);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishProvider = Provider.of<WishProvider>(context);

    print(productById);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(productById.imageUrl),
            )),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                productById.title,
                                maxLines: 2,
                                style: TextStyle(
                                  // color: Theme.of(context).textSelectionColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${productById.price}',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          productById.description,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _details('Brand: ', productById.brand),
                      _details('Quantity: ', '${productById.quantity} Left'),
                      _details('Category: ', productById.productCategoryName),
                      _details('Popularity: ', '${productById.isPopular}'),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),

                      // const SizedBox(height: 15.0),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount: suggestedProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                          value: suggestedProducts[index],
                          child: FeedsProduct());
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "DETAIL",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: AppColors.primaryColor,
                      disabledColor: Colors.grey,
                      onPressed: cartProvider.cartItems.containsKey(productId)
                          ? null
                          : () {
                              cartProvider.addProductToCart(
                                  productById.title,
                                  productById.imageUrl,
                                  productById.price,
                                  productId);
                            },
                      child: Text(
                        cartProvider.cartItems.containsKey(productId)
                            ? 'already added'.toUpperCase()
                            : 'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black26,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: InkWell(
                      splashColor: Colors.orange,
                      onTap: () {
                        wishProvider.addProductToWishList(productById.title,
                            productById.imageUrl, productById.price, productId);
                      },
                      child: Center(
                          child: wishProvider.wishItems.containsKey(productId)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.yellow,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.yellow,
                                )),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  Widget _details(String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

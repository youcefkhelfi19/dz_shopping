import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({@required this.productId});
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context, listen: false);
    final productAtt = productData.findById(productId);
    final cart = Provider.of<CartProvider>(context);
    final favo = Provider.of<WishProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: AppColors.primaryColor,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Image.network(
              productAtt.imageUrl,
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(context, 0, () {
                      favo.addProductToWishList(productAtt.title,
                          productAtt.imageUrl, productAtt.price, productId);
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    }),
                  ),
                  Flexible(
                    child: dialogContent(context, 1, () {
                      Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: productId)
                          .then((value) => Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null);
                    }),
                  ),
                  Flexible(
                    child: dialogContent(
                      context,
                      2,
                      cart.cartItems.containsKey(productId)
                          ? null
                          : () {
                              cart.addProductToCart(
                                  productAtt.title,
                                  productAtt.imageUrl,
                                  productAtt.price,
                                  productId);
                              Navigator.pop(context);
                            },
                    ),
                  ),
                ]),
          ),

          /************close****************/
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                shape: BoxShape.circle),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function fct) {
    final cart = Provider.of<CartProvider>(context);
    final favo = Provider.of<WishProvider>(context);
    List<IconData> _dialogIcons = [
      favo.wishItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Feather.eye,
      AppIcons.bag,
      AppIcons.trash,
    ];

    List<String> _texts = [
      favo.wishItems.containsKey(productId) ? 'In wishlist' : 'Add to wishlist',
      'View product',
      cart.cartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color> _colors = [
      favo.wishItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      cart.cartItems.containsKey(productId)
          ? Colors.grey
          : Theme.of(context).textSelectionColor,
    ];
    // final themeChange = Provider.of<DarkThemeProvider>(context);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //  fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
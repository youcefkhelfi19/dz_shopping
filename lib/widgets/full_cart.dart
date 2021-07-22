import 'package:dz_shopping/models/cart.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullCart extends StatefulWidget {
  FullCart({this.productId});

  final String productId;

  @override
  _FullCartState createState() => _FullCartState();
}

class _FullCartState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    final cartAtt = Provider.of<Cart>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAtt.quantity * cartAtt.price;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: widget.productId);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            color: Colors.grey),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3.0),
                        color: Colors.grey[300],
                        blurRadius: 1.0)
                  ],
                  color: Colors.white),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        image: DecorationImage(
                            image: NetworkImage(cartAtt.imageUrl),
                            fit: BoxFit.fill)),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            cartAtt.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )),
                          Flexible(
                              child: Text(
                            'Price:${cartAtt.price}DA\nSub Total: ${subTotal}DA',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                          Flexible(
                              child: Text(
                            'Ships free',
                            style: TextStyle(color: Colors.grey),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 2.0,
              top: 2.0,
              child: InkWell(
                onTap: () {
                  GlobalServices().customDialog(
                      'Delete Item',
                      'Are you sure you want o delete ${cartAtt.title}',
                      () => cartProvider.removeItem(widget.productId),
                     context
                  );
                },
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Container(
                padding: EdgeInsets.all(3.0),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3.0),
                        color: Colors.grey[400],
                        blurRadius: 1.0)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: cartAtt.quantity < 2
                          ? null
                          : () {
                              cartProvider
                                  .reduceProductFromCart(widget.productId);
                            },
                      child: Icon(
                        Icons.remove,
                        color: cartAtt.quantity < 2
                            ? Colors.grey[300]
                            : Colors.grey[600],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    Text(
                      '${cartAtt.quantity}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    InkWell(
                      onTap: () {
                        cartProvider.addProductToCart(cartAtt.title,
                            cartAtt.imageUrl, cartAtt.price, widget.productId);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

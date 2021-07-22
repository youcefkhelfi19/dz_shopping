import 'package:dz_shopping/models/cart.dart';
import 'package:dz_shopping/models/order_model.dart';
import 'package:dz_shopping/provider/orders_provider.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullOrder extends StatelessWidget {
  final String productId;
  FullOrder({this.productId});


  @override
  Widget build(BuildContext context) {
    final orderAtt = Provider.of<Order>(context);
    var orderProvider = Provider.of<OrderProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productId);
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
                             image: NetworkImage(orderAtt.imageUrl),
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
                                orderAtt.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          Flexible(
                              child: Text(
                                '${orderAtt.price}',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              )),
                          Flexible(
                              child: Text(
                                '${orderAtt.quantity}',
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
                      'Are you sure you want o delete ${orderAtt.title}',
                          () => {
                           orderProvider.deleteOrder(orderAtt.orderId),
                          },
                      context
                  );
                },
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

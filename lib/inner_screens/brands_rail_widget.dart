import 'package:dz_shopping/models/product.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandsNavigationRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productAtt = Provider.of<Product>(context,listen: false);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: productAtt.id);

      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 5.0)
            ]
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width*0.35,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                image: DecorationImage(
                    image: NetworkImage(
                      productAtt.imageUrl,
                  ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)
                ),

              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width*0.49,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  ),

              padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productAtt.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      fontSize:20.0
                    ),
                  ),

                  FittedBox(
                    child: Text('${productAtt.price}',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        )),
                  ),

                  Text(productAtt.brand,
                      style: TextStyle(color: Colors.grey, fontSize: 18.0)),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/models/product.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:dz_shopping/widgets/feed_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsProduct extends StatefulWidget {
  @override
  _FeedsProductState createState() => _FeedsProductState();
}

class _FeedsProductState extends State<FeedsProduct> {
  @override
  Widget build(BuildContext context) {
    final  productAtt = Provider.of<Product>(context);
    return InkWell(
      onTap: (){
       Navigator.pushNamed(context, ProductDetails.routeName,arguments: productAtt.id);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        //height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0,3.0),
                  color: Colors.grey[300],
                  blurRadius: 1.0
              )
            ],
          color: Colors.white
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height*0.2,
                      minHeight: MediaQuery.of(context).size.height*0.14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(productAtt.imageUrl),
                        fit: BoxFit.fill
                      ),
                    ),
                  ),
                ),
              productAtt.isNew ?  Badge(
                  toAnimate: false,
                  shape: BadgeShape.square,
                  badgeColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)
                  ),
                  badgeContent: Text('New', style: TextStyle(color: Colors.white)),
                ): Container(),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0,right: 10.0,left:10.0),
              //height: MediaQuery.of(context).size.height*0.12,

              width: MediaQuery.of(context).size.width*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productAtt.title,
                style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),
                ),
                  Text(productAtt.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey,fontSize: 16.0,),
                  ),
                  Text('${productAtt.price} DA',
                    style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity: ${productAtt.quantity}',
                      style: TextStyle(color: Colors.grey[500],fontSize: 12.0),
                      ),
                      InkWell(
                        splashColor: AppColors.primaryColor,
                          child: Icon(Icons.more_horiz,color: Colors.grey,),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  FeedDialog(
                                    productId: productAtt.id,
                                  ));                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

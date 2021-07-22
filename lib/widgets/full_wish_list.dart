import 'package:badges/badges.dart';
import 'package:dz_shopping/models/wish_model.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullWishList extends StatefulWidget {
  FullWishList({this.productId});

  final String productId;
  @override
  _FullWishListState createState() => _FullWishListState();
}

class _FullWishListState extends State<FullWishList> {
  @override
  Widget build(BuildContext context) {
    final wishAtt = Provider.of<Wish>(context);
    final wishProvider = Provider.of<WishProvider>(context);
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductDetails.routeName, arguments: widget.productId
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(wishAtt.imageUrl), fit: BoxFit.fill),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: InkWell(
                  onTap: () {
                    GlobalServices().customDialog(
                        'Remove Item',
                        'Are you sure you want to delete ${wishAtt.title}',
                        () => wishProvider.removeItem(widget.productId),
                        context);
                  },
                  child: Badge(
                    toAnimate: false,
                    shape: BadgeShape.square,
                    badgeColor: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    badgeContent: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3.0),
                    color: Colors.grey[300],
                    blurRadius: 1.0),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  wishAtt.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '${wishAtt.price}',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

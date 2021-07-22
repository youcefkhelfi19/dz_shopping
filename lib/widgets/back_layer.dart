import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/feeds.dart';
import 'package:dz_shopping/auth_screens/upload_product_form.dart';
import 'package:dz_shopping/screens/wish_list.dart';
import 'package:flutter/material.dart';

class BackLayerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.grey[300],
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),

        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height*0.13,
                    width: MediaQuery.of(context).size.width*0.27,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      //   clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                content(context, () {
                 Navigator.push(context, MaterialPageRoute(builder:(context)=>Feeds()));
                }, 'Feeds', 0),
                const SizedBox(height: 10.0),
                content(context, () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Cart()));
                }, 'Cart', 1),
                const SizedBox(height: 10.0),
                content(context, () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>WishList()));
                }, 'Wishlist', 2),
                const SizedBox(height: 10.0),
                content(context, () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>UploadProductForm()));
                }, 'Upload a new product', 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List _contentIcons = [
    AppIcons.feeds,
    AppIcons.bag,
    AppIcons.favOff,
    AppIcons.upload
  ];


  Widget content(BuildContext ctx, Function fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}

import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:dz_shopping/widgets/empty_wish_list.dart';
import 'package:dz_shopping/widgets/full_wish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget {
  static String routeName = '/WishList';
  @override
  Widget build(BuildContext context) {
    final wishProvider = Provider.of<WishProvider>(context);
    return wishProvider.wishItems.isEmpty? Scaffold(
      backgroundColor: Colors.white,
      body: EmptyWishList(),
    ):Scaffold(
      appBar: AppBar(
        title: Text('Wish List (${wishProvider.wishItems.length})',
          style: TextStyle(color: AppColors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              icon:Icon(AppIcons.trash,
                color: Colors.white,
              ),
              onPressed:(){
                GlobalServices().customDialog('Clear List', 'Are you sure You want to delete all items', ()=>wishProvider.clearCart(), context);
              })
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: GridView.count(crossAxisCount: 2,
            childAspectRatio: 0.85,
            children: List.generate(wishProvider.wishItems.length, (index){
              return ChangeNotifierProvider.value(
                  value: wishProvider.wishItems.values.toList()[index],
                  child: FullWishList(
                    productId: wishProvider.wishItems.keys.toList()[index],
                  ));
            })
        ),
      )
    );
  }

}

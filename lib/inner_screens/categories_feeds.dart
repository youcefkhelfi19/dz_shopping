import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/widgets/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFeeds extends StatelessWidget {
  static String routeName = '/CategoriesFeeds';

  @override
  Widget build(BuildContext context) {
    final  products = Provider.of<Products>(context,listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String ;
    final productsList = products.findByCategory(categoryName);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(categoryName,
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: GridView.count(crossAxisCount: 2,
            childAspectRatio: 0.68,
            children: List.generate(productsList.length, (index){
              return ChangeNotifierProvider.value(
                value: productsList[index],
                child: productsList.length >0?FeedsProduct():Scaffold(
                  body: Center(
                    child: Text('No products',style: TextStyle(color:Colors.black),),
                  ),
                ),
              );
            })
        )
    );
  }
}

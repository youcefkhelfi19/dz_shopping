import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/orders_provider.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:dz_shopping/widgets/empty_order.dart';
import 'package:dz_shopping/widgets/full_order.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  static String routeName = '/Orders';

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);

    return FutureBuilder<Object>(
      future:orderProvider.fetchOrders(),
      builder: (context, snapshot) {
        return orderProvider.orders.isEmpty
            ? Scaffold(
                backgroundColor: Colors.white,
                body: EmptyOrder(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                     'Orders (${orderProvider.orders.length})',
                    style: TextStyle(color: AppColors.white),
                  ),
                  elevation: 0.0,
                  backgroundColor: AppColors.primaryColor,
                  actions: [
                    IconButton(
                        icon: Icon(
                          AppIcons.trash,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          GlobalServices().customDialog(
                              'Clear List',
                              'Are you sure you want to delete all items ? ',
                              () => () {
                                orderProvider.deleteOrders();
                              },
                              context);
                        })
                  ],
                ),
                body: Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.07,
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: orderProvider.orders.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: orderProvider.orders[index],
                            child: FullOrder(),
                          );
                        }))
              );
      }
    );
  }
}

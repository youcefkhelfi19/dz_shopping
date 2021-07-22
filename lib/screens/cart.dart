import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/app_icons.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:dz_shopping/services/payment.dart';
import 'package:dz_shopping/widgets/empty_cart.dart';
import 'package:dz_shopping/widgets/full_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Cart extends StatefulWidget {
  static String routeName = '/Cart';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var response;
  @override
  void initState() {
     StripeService.init();
    super.initState();
  }
  Future<void> payWithCard({int amount})async{
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(child: Text('Pleas wait'));
    await dialog.show();
     response = await StripeService.payWithNewCard(amount: amount.toString(),currency: 'DZD');
    dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(seconds: response.success? 2:3),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.cartItems.isEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: EmptyCart(),
          )
        : Scaffold(
            bottomSheet: checkOutSection(context,cartProvider.totalAmount),
            appBar: AppBar(
              title: Text(
                'Cart (${cartProvider.cartItems.length})',
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
                          () => cartProvider.clearCart(),
                         context
                      );
                    })
              ],
            ),
            body: Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07,
                ),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.cartItems.values.toList()[index],
                        child: FullCart(
                          productId:
                              cartProvider.cartItems.keys.toList()[index],
                        ),
                      );
                    })),
          );
  }

  Widget checkOutSection(BuildContext context,totalPrice) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;

    final  uuid = Uuid();
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: AppColors.primaryColor,
            onPressed: ()async {
              double amountInCentime = totalPrice*100;
              int integerAmount = (amountInCentime/10).ceil();
             await payWithCard(amount:integerAmount );
             if(response.success == true){
               cartProvider.cartItems.forEach((key, orderElement) async{
                 final orderId = uuid.v4();

                 try{
                   await FirebaseFirestore.instance.collection('Orders').doc(orderId).set(

                       {
                         'orderId':orderId,
                         'userId':user.uid,
                         'title':orderElement.title,
                         'price':orderElement.price * orderElement.quantity,
                         'quantity':orderElement.quantity,
                         'imageUrl':orderElement.imageUrl,
                         'productId' : orderElement.productId,
                         'orderDate' : Timestamp.now(),
                       }
                   );
                 }catch (error){
                   print(error);
                 }
               });
             }else{
               GlobalServices().authErrorDialog('Try to use correct infos', context);
             }

            },
            child: Text(
              'Check out',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Total : ${totalPrice}DA',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  
}

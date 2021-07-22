import 'package:dz_shopping/constans/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/cart.jpg'
              ),
              fit: BoxFit.fill,
            )
          ),
        ),
        Text('Your cart is empty',
        style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
          child: Text('Looks like you didn\'t add any item in your cart !',
          textAlign:TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
          ),
        ),
        MaterialButton(
             height: MediaQuery.of(context).size.height*0.06,
             minWidth: MediaQuery.of(context).size.width*0.8,
           color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text('Shop now',
            style: TextStyle(color:  Colors.white,fontSize: 20.0),
            ),
            onPressed: (){

            }),
      ],
    );
  }
}

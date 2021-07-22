import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/provider/orders_provider.dart';
import 'package:flutter/material.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(30.0),
          height: MediaQuery.of(context).size.height*0.3,

          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/blank.png'
                ),
                fit: BoxFit.fill,
              )
          ),
        ),
        Text('You have no order',
          style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
          child: Text('Looks like you didn\'t order any item !',
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

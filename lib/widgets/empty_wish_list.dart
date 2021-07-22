import 'package:dz_shopping/constans/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyWishList extends StatelessWidget {
  const EmptyWishList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.3,
          width: MediaQuery.of(context).size.width*0.6,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/empty_bag.png'
                ),
                fit: BoxFit.fill,

              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Your wish list is empty',
            style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
          child: Text('Looks like you didn\'t add any item in your wish list !',
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
            child: Text('Add now',
              style: TextStyle(color:  Colors.white,fontSize: 20.0),
            ),
            onPressed: (){

            }),
      ],
    );
  }
}

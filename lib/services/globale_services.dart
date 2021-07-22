import 'package:flutter/material.dart';

class GlobalServices{
  Future<void> customDialog(
      String title, String subtitle, Function delete,BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'images/mark.png',
                  height: 30.0,
                  width: 30.0,
                ),
                Text(title),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    delete();
                    Navigator.pop(context);
                  },
                  child: Text('Yes'))
            ],
          );
        });
  }
  Future<void> authErrorDialog(
       String subtitle,BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'images/mark.png',
                  height: 30.0,
                  width: 30.0,
                ),
                SizedBox(width: 30.0,),
                Text('Error occured'),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),

            ],
          );
        });
  }
 void loadingDialog(BuildContext context)  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Adding Product'),
                CircularProgressIndicator(
                  backgroundColor: Colors.brown,
                )
              ],
            )
          );
        });
  }

}
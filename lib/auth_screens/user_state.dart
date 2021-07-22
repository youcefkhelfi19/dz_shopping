import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/screens/bottom_bar.dart';
import 'package:dz_shopping/auth_screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends StatelessWidget {
  const UserState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, userSnapshot){
          if(userSnapshot.connectionState ==  ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(userSnapshot.connectionState ==  ConnectionState.active){
            if(userSnapshot.hasData){

              return BottomTabs();
            }else{
              return SplashScreen();
            }
          }else if(userSnapshot.hasError){
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );

          }
        });
  }
}

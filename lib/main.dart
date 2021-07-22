import 'package:dz_shopping/auth_screens/reset_password.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/constans/theme_data.dart';
import 'package:dz_shopping/inner_screens/brands_navigation_rail.dart';
import 'package:dz_shopping/inner_screens/categories_feeds.dart';
import 'package:dz_shopping/provider/cart_provider.dart';
import 'package:dz_shopping/provider/dark_theme_provider.dart';
import 'package:dz_shopping/provider/orders_provider.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/provider/wish_provider.dart';
import 'package:dz_shopping/screens/cart.dart';
import 'package:dz_shopping/screens/details.dart';
import 'package:dz_shopping/screens/feeds.dart';
import 'package:dz_shopping/screens/home.dart';
import 'package:dz_shopping/auth_screens/login.dart';
import 'package:dz_shopping/auth_screens/sign_up.dart';
import 'package:dz_shopping/auth_screens/user_state.dart';
import 'package:dz_shopping/screens/orders.dart';
import 'package:dz_shopping/screens/wish_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkTheme darkTheme = DarkTheme();
  void getCurrentTheme() async {
    darkTheme.darkTheme = await darkTheme.darkThemePreference.getDartTheme();
  }
Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(
            home: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.brown,
                ),
              ),
            ),
          );
        }else if(snapshot.hasError){
          return MaterialApp(
            home: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: Text('Error ',style: TextStyle(color: Colors.brown,fontSize: 35.0,fontWeight: FontWeight.bold),)
              ),
            ),
          );
        }
        return MultiProvider(

            providers: [
              ChangeNotifierProvider(create: (_){
                return OrderProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return darkTheme;
              }),
              ChangeNotifierProvider(create: (_) {
                return Products();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishProvider();
              }),

            ],
            child: Consumer<DarkTheme>(builder: (context, themeData, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(darkTheme.isDark, context),
                home: UserState(),
                routes: {
                  Feeds.routeName: (context) => Feeds(),
                  Cart.routeName: (context) => Cart(),
                  WishList.routeName: (context) => WishList(),
                  Login.routeName: (context) => Login(),
                  SignUp.routeName: (context) => SignUp(),
                  Orders.routeName: (context) => Orders(),
                  Home.routeName: (context) => Home(),
                  ResetPassword.routeName: (context) => ResetPassword(),
                  CategoriesFeeds.routeName: (context) => CategoriesFeeds(),
                  ProductDetails.routeName: (context) => ProductDetails(),
                  BrandNavigationRailScreen.routeName: (context) =>
                      BrandNavigationRailScreen()
                },
              );
            }));
      }
    );
  }
}

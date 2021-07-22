import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/provider/products_list.dart';
import 'package:dz_shopping/screens/bottom_bar.dart';
import 'package:dz_shopping/auth_screens/login.dart';
import 'package:dz_shopping/auth_screens/sign_up.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  Future<void> googleSingIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final googleSingIn = GoogleSignIn();
      final googleAccount = await googleSingIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult =await  _auth.signInWithCredential(GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken));
          FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set(
              {
                'id':authResult.user.uid,
                'name':authResult.user.displayName,
                'email':authResult.user.email,
                'imageUrl': authResult.user.photoURL,
                'phoneNumber':authResult.user.phoneNumber,
                'createdAt':Timestamp.now(),
              }
          );
        }
      }
    } catch (error) {
      GlobalServices().authErrorDialog(error.message, context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1519500099198-fd81846b8f03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
            placeholder: (context, url) => Image.network(
              'https://images.unsplash.com/photo-1519500099198-fd81846b8f03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 50.0),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'The first shopping app in ...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Icon(
                                            Feather.user,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: Colors.white,
                                                width: 1.0)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Login.routeName);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Icon(
                                            Feather.user_plus,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.pink),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: Colors.white,
                                                width: 1.0)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, SignUp.routeName);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 2.0,
                                    color: Colors.black38,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2.0,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  googleSingIn();
                                },
                                child: Text('Google +',
                                    style: TextStyle(color: Colors.red)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 2.0,
                                            color: AppColors.primaryColor)),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomTabs()));
                                },
                                child: Text('As a Guest',
                                    style: TextStyle(color: Colors.black)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 2.0,
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

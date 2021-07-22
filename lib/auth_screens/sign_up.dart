import 'dart:io';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wave/wave.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);
  static String routeName = '/SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _isLoading = false;
  String _emailAddress = '';
  String _password = '';
  int  _phone;
  String _userName = '';
  File _pickedImage;
  final _formKey = GlobalKey<FormState>();
  void _submitForm()async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();

      try{
        if(_pickedImage == null){
          GlobalServices().authErrorDialog('Please add a picture', context);
        }else{
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance.ref().child('usersPics').child('$_userName.jpg');
          await ref.putFile(_pickedImage);
          var url = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(email: _emailAddress.trim(), password: _password.trim()).then((value){
            Navigator.canPop(context)? Navigator.pop(context):null;

          });
          final User user = _auth.currentUser;
          final String uid = user.uid;
          user.updateDisplayName(_userName);
          user.updatePhotoURL(url);
          user.reload();
          FirebaseFirestore.instance.collection('users').doc(uid).set(
              {
                'id':uid,
                'name':_userName,
                'email':_emailAddress,
                'imageUrl': url,
                'phoneNumber':_phone,
                'createdAt':Timestamp.now(),
              }
          );
        }

      }catch(error){
         GlobalServices().authErrorDialog(error.message, context);
      }finally{
        setState(() {
          _isLoading = false;
        });
      }

    }
  }
  void pickImageFromCamera()async{
    final imagePicker = ImagePicker();
    final image = await imagePicker.getImage(source: ImageSource.camera,imageQuality: 10);
    final imageFile = File(image.path);
    setState(() {
      _pickedImage = imageFile;
    });
    Navigator.pop(context);

  }
  void pickImageFromGallery()async{
    final imagePicker = ImagePicker();
    final image = await imagePicker.getImage(source: ImageSource.gallery,imageQuality: 10);
    final imageFile = File(image.path);
    setState(() {
      _pickedImage = imageFile;
    });
    Navigator.pop(context);

  }
  void removeImage(){
    setState(() {
      _pickedImage = null ;
    });
    Navigator.pop(context);

  }
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [AppColors.primaryColor, Colors.orange],
                [Colors.white, Color(0x55FFEB3B)],
                [Colors.orange, Color(0x66FF9800)],
                [Colors.white, Color(0x55FFEB3B)]
              ],
              durations: [50000, 30440, 10800, 60000],
              heightPercentages: [0.60, 0.63, 0.75, 0.70],
              blur: MaskFilter.blur(BlurStyle.solid, 5),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),

            waveAmplitude: 5,

            backgroundColor: Colors.white,
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.1 ,),

                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 5.0,
                          color: Colors.brown
                        )
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: _pickedImage == null ? AssetImage('images/person.png',):
                            FileImage(_pickedImage)
                      ),
                    ),
                    Positioned(
                      bottom: 15.0,
                      right: 15.0,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 3.0,
                                color: Colors.white
                            )
                        ),
                        child: InkWell(
                             splashColor: Colors.orange,
                            child: Icon(Icons.add_a_photo,color: Colors.pink,),
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: Text('Choose an option',
                                style: TextStyle(color: Colors.orange,fontSize: 18.0),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.orange,
                                        child: Row(
                                          children: [
                                            Icon(Icons.camera,color: Colors.orange,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                              child: Text('Take a picture',style: TextStyle(color: Colors.black),),
                                            )
                                          ],
                                        ),
                                        onTap: (){
                                          pickImageFromCamera();
                                        },
                                      ),
                                      InkWell(
                                        splashColor: Colors.orange,
                                        child: Row(
                                          children: [
                                            Icon(Icons.photo,color: Colors.blue,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                              child: Text('From Gallery',style: TextStyle(color: Colors.black),),
                                            )
                                          ],
                                        ),
                                        onTap: (){
                                         pickImageFromGallery();
                                        },
                                      ),
                                      InkWell(
                                        splashColor: Colors.orange,
                                        child: Row(
                                          children: [
                                            Icon(Icons.remove_circle,color: Colors.red,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                              child: Text('Remove',style: TextStyle(color: Colors.black),),
                                            )
                                          ],
                                        ),
                                        onTap: (){
                                        removeImage();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        ),

                      ),
                    )
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: TextFormField(
                            key: ValueKey('User name'),
                            validator: (value) {
                              if (value.isEmpty ) {
                                return 'User name can\' be empty';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                fillColor: Colors.orange[100],
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'User name'
                            ),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_phoneFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                fillColor: Colors.orange[100],
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Email address'
                            ),
                            onSaved: (value) {
                              _emailAddress = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: TextFormField(
                            key: ValueKey('phone'),
                            focusNode: _phoneFocusNode,
                            validator: (value) {
                              if (value.isEmpty || value.length<9) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.orange[100],
                                filled: true,
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Phone'
                            ),
                            onSaved: (value) {
                              _phone = int.parse(value);
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            focusNode: _passwordFocusNode,
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _submitForm,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                focusColor: Colors.brown,

                                fillColor: Colors.orange[100],
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,color:Colors.brown,),
                                ),

                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Password'
                            ),
                            obscureText: _obscureText,
                            onSaved: (value) {
                              _password = value;
                            },
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.1 ,),
                _isLoading? CircularProgressIndicator(
                  backgroundColor: Colors.brown,
                  strokeWidth: 5.0,
                )
                    : Container(
                  height: MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text('Sing up',
                          style: TextStyle(color: Colors.white,fontSize: 18.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(Feather.user,color: Colors.white,size: 18,),
                        )
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Colors.white,
                                width: 1.0
                            )
                        ),

                      ),

                    ),
                    onPressed: (){
                      _submitForm();
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

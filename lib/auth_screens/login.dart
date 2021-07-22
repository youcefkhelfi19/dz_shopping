import 'package:dz_shopping/auth_screens/reset_password.dart';
import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
static String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _isLoading = false;
  String _emailAddress = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  void _submitForm()async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try{
        await _auth.signInWithEmailAndPassword(email: _emailAddress.trim(), password: _password.trim()).then((value){
          Navigator.canPop(context)? Navigator.pop(context): null;
        });
      }catch(error){
        GlobalServices().authErrorDialog(error.message, context);
      }finally{
        setState(() {
          _isLoading = false;
        });
      }

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
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
              heightPercentages: [0.40, 0.43, 0.55, 0.50],
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.15 ,),

              Text('Login',
               style: TextStyle(color: Colors.orange,fontSize: 50.0,fontWeight: FontWeight.bold),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.18 ,
                child: Image.asset('images/login.png'),
              ),
              Form(
                key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
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
                              hintText: 'Email'
                          ),
                          onSaved: (value) {
                            _emailAddress = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
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
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: (){
                          Navigator.pushNamed(context, ResetPassword.routeName);
                          },
                          child: Text('Forget password ?',
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 18.0
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.1 ,),
             _isLoading? CircularProgressIndicator(
               backgroundColor: Colors.brown,
               strokeWidth: 5.0,
             ): Container(
                height: MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width*0.5,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text('Login',
                        style: TextStyle(color: Colors.white,fontSize: 18.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(Feather.user,color: Colors.white,size: 18,),
                      )
                    ],
                  ),
                  style: ButtonStyle(

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

        ],
      ),
    );
  }
}

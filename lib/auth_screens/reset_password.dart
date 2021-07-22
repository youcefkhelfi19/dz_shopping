import 'package:dz_shopping/constans/app_colors.dart';
import 'package:dz_shopping/services/globale_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toast/toast.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);
  static String routeName = '/ResetPassword';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _emailAddress = '';
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
        await _auth.sendPasswordResetEmail(email: _emailAddress.trim());
        Toast.show("An email has been sent ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        Navigator.canPop(context)?Navigator.pop(context):null;

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

            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.15 ,),

              Text('Reset Password',
                style: TextStyle(color: Colors.orange,fontSize: 45.0,fontWeight: FontWeight.bold),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.18 ,
                child: Image.asset('images/reset.png'),
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
                      Text('Reset',
                        style: TextStyle(color: Colors.white,fontSize: 18.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(Feather.lock,color: Colors.white,size: 18,),
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

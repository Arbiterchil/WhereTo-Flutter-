import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:WhereTo/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';
import 'homepage.dart';


  class LoginPage extends StatefulWidget{
  @override
    _LoginPageState createState() => _LoginPageState();

  }


class _LoginPageState extends State<LoginPage>{
  var userData;
  bool isLoading = false;
    final key = GlobalKey<FormState>();
     TextEditingController contactNumber =  TextEditingController();
      TextEditingController passwordController =  TextEditingController();

      phoneValidate(String val){

          Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
          RegExp regExp = new RegExp(pattern);
          if (val.length == 0 ){
            return 'Please enter your number';
          }
          else if(!regExp.hasMatch(val)){
            return 'Enter A Valid Contact Number';
          }
          else{
            return null;
          }

    }
    Widget _formGet(BuildContext context){
      return Form(
        key: key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
           Text('Contact Number',
            style: eLabelStyle,
            ),
            SizedBox(height: 10.0,),
             Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: contactNumber,
                validator: (val){
                  return phoneValidate(val);
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  hintText: 'Contact Number',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 30.0,),
             Text('Password',
            style: eLabelStyle,
            ),
            SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: passwordController,
                validator: (val) => val.isEmpty ? ' Please Put Your Password' : null,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: '******',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: (){},
                padding: EdgeInsets.only(right: 0.0),
                 child: Text('Forget Password',
                 style: eLabelStyle,
                 ),
                 ),
            ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: RaisedButton(
                  onPressed: (){
                    _login();
                  },
                  elevation: 5.0,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(  isLoading ? 'Loading....' : 'LOGIN',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),),
                  ),
              ),
          ],
        ),
        ),
      );
  }

     Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
      color: sb3,
      offset: Offset(10, 10),
      blurRadius: 10
    ),
    BoxShadow(
      color: b2,
      offset: Offset(-10, -10),
      blurRadius: 10
    )
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'asset/img/fb.png',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'asset/img/gmail.png',
            ),
          ),
        ],
      ),
    );
  }
  Widget _botDownSignUp(){
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return SignupPage();
        }));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
 body: Container(
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
                   color:  Color(0xFF398AE5)
                  ),
                 child: SafeArea(
                   child: SingleChildScrollView(
                     physics: AlwaysScrollableScrollPhysics(),
                     padding: EdgeInsets.symmetric(
                       horizontal: 40.0,
                       vertical: 80.0,
                     ),
                     
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                             Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: 130.0,
                            height: 130.0,
                            child: Image.asset("asset/img/logo.png"),
                          ),
                          _formGet(context),
                          SizedBox(height: 15.0,),
                          Text(
                            '- OR -',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Sign in with',
                            style: eLabelStyle,
                          ),
                          _buildSocialBtnRow(),
                          SizedBox(height: 20.0),
                          _botDownSignUp(),
                        
                         ],
                     ),
                   ),
                 ), 
       ),
    );
  }

void _login() async{
 String hens ;
 

 setState(() {
      isLoading = true;
    });

    if(key.currentState.validate()){
      key.currentState.save();
       var data = {
        'contactNumber' : contactNumber.text, 
        'password' : passwordController.text
        ,};
    


    var res = await ApiCall().postData(data,'/login');
    
    if(res.statusCode == 200){
 var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
      hens = userData['status'].toString();
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => 
            PathWay(
              getStringthis: hens,
            )));
      print('success Login');
    }else{
      _showDial();
    }
    }else{
      _showDial();
    }
   
   
    }


   setState(() {
     isLoading =false;
   });

   

  


  }

void _showDial(){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
          title: Text("Contact Number or Password is not Match."),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
                FlatButton(onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK",textAlign: TextAlign.center,),),
              ],
           
        );
    },);
}
}


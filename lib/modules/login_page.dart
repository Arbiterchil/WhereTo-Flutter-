import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';


  class LoginPage extends StatefulWidget{
  @override
    _LoginPageState createState() => _LoginPageState();

  }

  

class _LoginPageState extends State<LoginPage>{

    final key = GlobalKey<FormState>();
     TextEditingController contactNumber =  TextEditingController();
      TextEditingController passwordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // backgroundColor: Color(0xFF205AFF),
      // backgroundColor: Colors.white,
      body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
               image: AssetImage("asset/img/bgback.png"),
            fit: BoxFit.cover,
              ),
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:40.0,),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("asset/img/app.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500.0,
                        margin: const EdgeInsets.only(top: 290.0,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(110.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0,left: 20.0, right: 20.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                             width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20.0),
                              child:
                              
                               Form(
                                key: key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     TextFormField(
                      validator: (val)=> contactNumber.text.length < 11 ? 'Mobile Number Consists of 11 Digits' :null,
                      controller: contactNumber,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(fontSize: 14,color: Color(0xFF205AFF),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF205AFF),
                          ),  
                        ),
                        
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFF205AFF),
                            )
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      
                    ),
                                      SizedBox(height: 25.0,),
                                      TextFormField(
                      validator: (val) => val.isEmpty ? ' Empty' : null,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14,color: Color(0xFF205AFF),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFF205AFF),
                          ),
                          
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFF205AFF),
                              
                            )
                        ),
                      ),
                    ),
                                     SizedBox(height: 15.0,),
                     
                                    Align(
                      alignment: Alignment.topRight,
                      child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                    ),
                                    SizedBox(height: 50.0,),
                                    Container(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(    
                        onPressed:  _login,
                        padding: EdgeInsets.all(0),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                               Color(0xFF205AFF),
                                Color(0xFF1261A0),
                              Color(0xFF205AFF),
                              ],
                            ),
                          ),
                        
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
            
                            child: Text("Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                                    SizedBox(height: 50.0,),
                                     Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("I'm a new user.",style: TextStyle(fontWeight: FontWeight.bold),),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return SignupPage();
                                      }));
                                    },
                                    child: Text("Sign Up",style:
                                    TextStyle(fontWeight: FontWeight.bold,color: Color(0xffffb400)),),
                                  )
                                ],
                              ),
                            ),
                                  ],
                                ),
                              ),

                            ),
                          ), 
                          ),
                      ),
                   
                      

                   
                ],
              ),
            ),
          ),
        
      ),
    );
  }

void _login() async{

    if(key.currentState.validate()){
      key.currentState.save();
       var data = {
        'contactNumber' : contactNumber.text, 
        'password' : passwordController.text
    };
    
    var res = await ApiCall().postData(data,'/login');
    
    if(res.statusCode == 200){
 var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Home()));
      print('success Login');
    }else{
      _showDial();
    }
    }else{
      _showDial();
    }
   
   
    }


   

  


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


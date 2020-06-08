import 'dart:convert';

import 'package:WhereTo/api/api.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text("Welcome in, Where To",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  SizedBox(height: 6,),
                  Text("Sign in to continue!",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                ],
              ),
              Column(
                key: key,
                children: <Widget>[
                  SizedBox(height: 180,),
                  TextFormField(
                    controller: contactNumber,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                     
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                        
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            
                          )
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      
                      onPressed:  _login,

                      padding: EdgeInsets.all(0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffffb400),
                              Color(0xffff5f6d),
                              Color(0xffffb400),
                            ],
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
            
                          child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
      

                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150,),
                    Text("I'm a new user.",style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignupPage();
                        }));
                      },
                      child: Text("Sign up",style:
                       TextStyle(fontWeight: FontWeight.bold,color: Color(0xffffb400)),),
                    )
                  ],
                ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }

void _login() async{
    var data = {
        'contactNumber' : contactNumber.text, 
        'password' : passwordController.text
    };
    
    var res = await ApiCall().postData(data,'/login');
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
      print(body['message']);
    }
   

  


  }

}


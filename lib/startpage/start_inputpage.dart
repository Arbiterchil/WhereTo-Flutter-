
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputMobileNumber extends StatefulWidget {
  @override
  _InputMobileNumberState createState() => _InputMobileNumberState();
}
class _InputMobileNumberState extends State<InputMobileNumber> {


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                  height: 160.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                        Container(
                        width: 110.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,    
                        ),
                        padding: EdgeInsets.only(top: 70.0,left: 20.0),
                        child: CircleAvatar(
                        backgroundImage: AssetImage('asset/img/nc.png'),
                          ),),

                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: SafeArea(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return LoginPage();
                                          }));
                                        },
                                        child: Text("Sign In",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.amber,
                                        ),),
                                      ),
                                      SizedBox(width: 10.0,),
                                      Text("|",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                      ),),
                                      SizedBox(width: 10.0,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return SignupPage();
                                          }));
                                        },
                                        child: Text("Sign Up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.amber,
                                        ),),
                                      ),
                                    ],
                                  
                                  ),
                                
                               
                            ),
                          ),
                          
                          ], 
                          ),
                     
                    ],
                  ),
                  
              ),
              SizedBox(height: 20.0),
              Container(
                height: 180.0,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                       padding: const EdgeInsets.only(right: 140.0, top: 110.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                        Text("Welcome!    ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28.0
                                        ),
                                      ),
                        Text("Enter Your Mobile",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                        ),
                                        ),              

                         ],
                       ),
                     ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text("+63",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: 10.0,),
                        Flexible(child:
                         Container(
                           width: 250.0,
                          padding: const EdgeInsets.all(12.0), 
                          child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val){
                        if(val.length < 8){
                          return "this is not mobile number ";
                        }if(val.length > 10){
                          return "Number should consist 9 Digits";
                        }
                        return null;
                      },
                      
                      decoration: InputDecoration(
                        
                        labelText: "Contact Number",
                        labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
          
                        ),
                      
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                    ),
                        ), ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height:  100.0,),
               Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                       padding: const EdgeInsets.only(right: 140.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                        Text("Or Continue with",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0
                                        ),
                                      ),
                        Text("A Social Account",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0
                                        ),
                                        ),              

                         ],
                       ),
                     ),
              ),
              SizedBox(height: 40.0,),
                Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[       
                       Container(
                         
                         height: 50,
                         width: 150.0,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: Colors.amber,
                         ),
                         child: FlatButton(
                           onPressed: (null),
                           child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
              
                              child: Text("Gmail",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,),
                            ),),
                       ),
                      SizedBox(width: 10.0,),
                      Container(
                         
                         height: 50,
                         width: 150.0,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: Colors.amber,
                         ),
                         child: FlatButton(
                           onPressed: (null),
                           child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
              
                              child: Text("Facebook",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,),
                            ),),
                       ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
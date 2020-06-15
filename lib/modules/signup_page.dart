import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';


class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>{
  
  final formkey = GlobalKey<FormState>();
    final TextEditingController fulname  = TextEditingController();
     TextEditingController ownNumber = TextEditingController();
      TextEditingController ownAddress =  TextEditingController();
      TextEditingController ownpass = TextEditingController();
      TextEditingController ownconpass =TextEditingController();

         bool loading = false;    


      



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          child:  SingleChildScrollView(
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text("Sign Up With Us,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  SizedBox(height: 6,),
                  Text("Create an Account to get started!",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                ],
                ),
               
                Form(
                  key: formkey,
                  child:
                  Column(
                children: <Widget>[
                  SizedBox(height: 70,),

                  TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Empty Field";
                      }
                      return null;
                    },
                    controller: fulname,
                    decoration: InputDecoration(
                      labelText: "Full Name",
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
                  
                  SizedBox(height: 16,),

                   TextFormField(
                     controller: ownAddress,
                     validator: (val){
                        if(val.isEmpty){
                          return "Empty";
                        }
                        return null;
                     },
                    decoration: InputDecoration(
                      labelText: "Address",
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
                  SizedBox(height: 16,),

                  TextFormField(
                    controller: ownpass,
                    validator: (input) => ownpass.text.length < 8 ?  'Password to Short' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
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
                  SizedBox(height: 30,),

                  TextFormField(
                    controller: ownconpass,
                    validator: (val){
                      if(val.isEmpty){
                        return "Empty";
                      }if(val != ownpass.text){
                        return "Password not Match";
                      }
                      return null;
                    },
                    onSaved: (val) => ownconpass.text = val,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                  SizedBox(height: 30,),

                  TextFormField(
                    controller: ownNumber,
                    keyboardType: TextInputType.number,
                    validator: (val) => ownNumber.text.length < 11 ? 'Mobile Number Consist of 11 Digits' : null,
                    onSaved: (val) => ownNumber.text = val,
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
                  SizedBox(height: 16,),

                  Container(
                    height: 50,
                    child: FlatButton(
                      
                      onPressed:  _signingIn,

                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                             Color(0xffffb400),
                              Color(0xffff5f6d),
                              Color(0xffffb400),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minHeight: 50,maxWidth: double.infinity),
                          child: Text( 
                            loading ? 'Creating Account' : "Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                ],
              ),
              ),
              
             
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150,),
                    Text("I'm already a member.",style:
                     TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                     onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LoginPage();
                        }));
                      },
                      child: Text("Sign in.",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
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

void _signingIn() async {

  setState(() {
    loading = true;
  });

  if(formkey.currentState.validate()){
      formkey.currentState.save();
      var data = {
        'name' : fulname.text,
        'contactNumber' : ownNumber.text,
        'address' : ownAddress.text,
        'password' : ownpass.text 
            };
      var res = await ApiCall().postData(data,'/register');

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
    }else{
      _showDial();
      throw Exception('Failed to Save');
          
    } 
  }else{
     _showDial();
    throw Exception('Failed to Save');  
        }

    


  }

  setState(() {
    loading = false;
  });


}

void _showDial(){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
          title: Text("Contant Number Already Exist."),
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

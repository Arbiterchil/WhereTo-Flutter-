import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/bara_rang.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';
import 'homepage.dart';


class MyChoice{

    String pickchoice;
    int numberpick;
    MyChoice({this.pickchoice,this.numberpick});
}



class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

 

class _SignupPageState extends State<SignupPage>{
  
    String default_pick = "Customer";
    int default_number = 1;
     String selectPerson;
     var idbararangSaika;
    List<MyChoice> picks = [
      MyChoice(numberpick: 1,pickchoice: "Customer"),
      MyChoice(numberpick: 2,pickchoice: "Rider")
    ];



  final formkey = GlobalKey<FormState>();
  
    TextEditingController fulname  = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController ownNumber = TextEditingController();
    TextEditingController ownAddress =  TextEditingController();
    TextEditingController ownpass = TextEditingController();
    TextEditingController ownconpass =TextEditingController();
      
        bool loading = false;

        phoneValidate(String val){

          Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
          RegExp regExp = new RegExp(pattern);
          if (val.length == 0 ){
            return 'Please enter your number';
          }else if (val.length < 11){
            return 'Mobile Number Consist of 11 Digits';
          }
          else if(!regExp.hasMatch(val)){
            return 'Enter A Valid Contact Number';
          }
          else{
            return null;
          }

    }   

  


    emailValidate(String value){
      Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
    }

      Widget _formRegister(BuildContext context){

            return Form(
              key: formkey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                     Text('Full Name',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: fulname,
                validator: (val) => val.isEmpty ? ' Please Put Your Full Name' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'Full Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text('Email',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: email,
                validator: (val)=> emailValidate(email.text = val),
                    onSaved: (val) => email.text = val,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Email',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
              SizedBox(height: 15.0,),

            Text("Barangay",
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:





            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.place,color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Barangay",
                                  style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Color(0xFF0C375B),
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  
                                  value: selectPerson,
                                  items: dataBarangay.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['barangayName'],
                                    style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      selectPerson = item;
                                      idbararangSaika = item;
                                      print(idbararangSaika);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),








                SizedBox(height: 15.0,),
                 Text('Address',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: ownAddress,
                validator: (val) => val.isEmpty ? ' Please Put Your Address' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                  hintText: 'Address',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
             SizedBox(height: 15.0,),
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
                cursorColor: Colors.white,
                controller: ownpass,
                validator: (input) => ownpass.text.length < 8 ?  'Password to Short' : null,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
                 Text('Confirm Password',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: ownconpass,
                validator:(val){
                      if(val.isEmpty){
                        return "Gilroy-light";
                      }if(val != ownpass.text){
                        return "Password not Match";
                      }
                      return null;
                    },
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
             SizedBox(height: 15.0,),
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
                cursorColor: Colors.white,
              keyboardType: TextInputType.number,
                controller: ownNumber,
                validator: (val)=> phoneValidate(ownNumber.text = val),
                    onSaved: (val) => ownNumber.text = val,
                    
                
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  hintText: '09**********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: RaisedButton(
                  onPressed: (){
                    _signingIn();
                  },
                  elevation: 5.0,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(  loading ? 'Loading....' : 'Register',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy-light',
                  ),),
                  ),
              ),


                  ],
                ),
              ),
            );


        }  
 Widget _botDownSignIn(){
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                        return LoginPage();
                                      }));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
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
  void initState() {
    super.initState();
    this.callBarangay();
  }

  
    List dataBarangay = List();

    callBarangay() async{

    var respon = await ApiCall().getBararang('/getBarangayList');
    var bararang = json.decode(respon.body);
  
    setState(() {
      dataBarangay = bararang;
    });
    print(bararang);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: WillPopScope(
       onWillPop: () async => false,
       child: Container(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
                      // color: Color(0xFF398AE5),
                      gradient: LinearGradient(
                              stops: [0.1,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
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
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-light',
                                letterSpacing: 1,
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            _formRegister(context),
                            SizedBox(height: 25.0,),

                            _botDownSignIn(),
                         ],
                       ),
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

    bool value = true;

  if(selectPerson == null){
    print("Select Barangay");
    _showDistictWarning();
  }else{
     if(formkey.currentState.validate()){
      formkey.currentState.save();
      var data = {
        'name' : fulname.text,
        'email': email.text,
        'contactNumber' : ownNumber.text,
        'address' : ownAddress.text,
        'password' : ownpass.text, 
        'barangayId': selectPerson.toString()
            };
      var res = await ApiCall().postData(data,'/register');

     if(res.statusCode == 200){
     var body = json.decode(res.body);
      if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setBool('check', value);
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
     
       Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => HomePage()));
    }else{
      _showDial();
      throw Exception('Failed to Save');
    } 
  }

  }
  }

  setState(() {
    loading = false;
  });


}

void _showDial(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustom(context),
    ); 
    },);
}
 mCustom(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Please check the fields Or Phone Number already Exists.",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      );


    }






void _showDistictWarning(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustomDistictWarning(context),
    ); 
    },);
}
 mCustomDistictWarning(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Please Select a District.",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      );


    }







}

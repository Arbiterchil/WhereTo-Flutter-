import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';

class RiderForms extends StatefulWidget {
  @override
  _RiderFormsState createState() => _RiderFormsState();
}

class _RiderFormsState extends State<RiderForms> {

    TextEditingController fullanme  = TextEditingController();
    TextEditingController addressmadafa = TextEditingController();
    TextEditingController contactnumber = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController licensenumber = TextEditingController();
    TextEditingController plateNumber = TextEditingController();

    final formkey = GlobalKey<FormState>();
    String selectPerson;
   bool loading = false;
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[

          Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white
                    )
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Center(
                        child: Icon(Icons.add,
                        size: 30,
                        color: Color(0xFF0C375B),
                        ),
                      ),
                    ),
                  ),
                ),
               ), 
          SizedBox(height: 10.0,),
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
                controller: fullanme,
                validator: (val) => val.isEmpty ? ' Please Put Your Restaurant Name' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.shop,
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
                controller: addressmadafa,
                validator: (val) => val.isEmpty ? ' Please Put A Address Name' : null,
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
                controller: contactnumber,
                validator: (val)=> phoneValidate(contactnumber.text = val),
                onSaved: (val) => contactnumber.text = val,    
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
                                      print(item);
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
          Text('License Number',
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
                controller: licensenumber,
                validator: (val) => val.isEmpty ? ' Please Put A License Number' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: Colors.white,
                  ),
                  hintText: 'License Number',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
          Text('Plate Name',
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
                controller: plateNumber,
                validator: (val) => val.isEmpty ? ' Please Put A Plate Number' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.details,
                    color: Colors.white,
                  ),
                  hintText: 'Plate Number',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
         Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: RaisedButton(
                  onPressed: (){

                 saveForm();
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
      
    );
  }

  void saveForm() async {

    setState(() {
    loading = true;
  });


    if(selectPerson == null){
    print("Select Barangay");
    _showDistictWarning();
  }else{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      var data = {
            "name" : fullanme.text,
            "email" : email.text,
            "contactNumber" : contactnumber.text,
            "address" : addressmadafa.text,
            "barangayId": selectPerson.toString(),
            "licenseNumber": licensenumber.text,
            "plateNumber": plateNumber.text
    };

    await ApiCall().addRider(data, '/addRider');
    fullanme.clear();
    email.clear();
    address.clear();
    contactnumber.clear();
    licensenumber.clear();
    plateNumber.clear();
    _showDone();
    }

  }

    


    setState(() {
    loading = false;
  });
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
  void _showDone(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustomDOne(context),
    ); 
    },);
}
 mCustomDOne(BuildContext context){

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
                  child: Text("Rider is Registered.",
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
                      
                  child: Text ( "OK", style :TextStyle(
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
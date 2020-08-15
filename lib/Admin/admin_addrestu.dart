import 'dart:convert';

import 'package:WhereTo/Admin/admin_addmenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:flutter/material.dart';

import '../styletext.dart';

class AdminAddRestaurant extends StatefulWidget {
  @override
  _AdminAddRestaurantState createState() => _AdminAddRestaurantState();
}

class _AdminAddRestaurantState extends State<AdminAddRestaurant> {

    

    final scaffoldKey = new GlobalKey<ScaffoldState>(); 
    TextEditingController retaurantname  = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController contactnumber = TextEditingController();
    final formkey = GlobalKey<FormState>();
    String selectPerson;
    String opentimeString;
    String closetimeString;
    String datesofdays;
    List dataBarangay = List();
    bool loading = false;


    addRestaurant() async {
      var data = 
      {

        "restaurantName": retaurantname.text,
        "address": address.text,
        "barangayId": selectPerson.toString(),
        "contactNumber": contactnumber.text,
        "openTime": opentimeString.toString(),
        "closingTime": closetimeString.toString(),
        "closeOn": datesofdays.toString(),
        "isFeatured": 1,

      };

      var response = await ApiCall().addRestaurant(data, '/addRestaurant');

       var body = json.decode(response.body);
      print(body);
        Navigator.pushReplacement(  
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AddmenuAdmin()));
    }

    List<String> weeks = 
    [
      "None",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thurday",
      "Friday",
      "Saturaday",
      "Sunday"
    ];
    List<String> opentime = 
    [
      "1:00:00",
      "2:00:00",
      "3:00:00",
      "4:00:00",
      "5:00:00",
      "6:00:00",
      "7:00:00",
      "8:00:00",
      "9:00:00",
      "10:00:00",
      "11:00:00",
      "12:00:00",

    ];
    List<String> closetime = 
    [
      "13:00:00",
      "14:00:00",
      "15:00:00",
      "16:00:00",
      "17:00:00",
      "18:00:00",
      "19:00:00",
      "20:00:00",
      "21:00:00",
      "22:00:00",
      "23:00:00",
      "24:00:00",

    ];

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
    
    Widget formAdd(){
      return Form(
        key: formkey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
            children: <Widget>[

               Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
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
               Text('Restaurant Name',
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
                controller: retaurantname,
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
                  hintText: 'Restaurant Name',
                  hintStyle: eHintStyle,
                ),
              ),
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
                controller: address,
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
                controller: contactNumber,
                validator: (val)=> phoneValidate(contactNumber.text = val),
                    onSaved: (val) => contactNumber.text = val,
                    
                
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
            Text("Open Time",
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
                            child: Icon(Icons.access_time,
                            color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Open Time",
                                  style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Color(0xFF0C375B),
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  
                                  value: opentimeString,
                                  items: opentime.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item,
                                    style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      opentimeString = item;
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
            Text("Close Time",
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
                            child: Icon(Icons.timer_off,
                            color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Close Time",
                                  style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Color(0xFF0C375B),
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  
                                  value: closetimeString,
                                  items: closetime.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item,
                                    style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      closetimeString = item;
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
            Text("Close On",
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
                            child: Icon(Icons.weekend,
                            color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Close On Day",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Color(0xFF0C375B),
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  
                                  value: datesofdays,
                                  items: weeks.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item,
                                    style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      datesofdays = item;
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

              SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: RaisedButton(
                  onPressed: (){

                    Navigator.pushReplacement(  
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AddmenuAdmin()));
                  // addRestaurant();
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

    

  @override
  void initState() {
    super.initState();
    this.callBarangay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    formAdd(),
                  
                ],
              ),
            ),
            ),
        ),
        onWillPop: () async => false),
    );
  }
}
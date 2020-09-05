import 'package:WhereTo/Transaction/MyOrder/payOrder.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressLine extends StatefulWidget {
  @override
  _AddressLineState createState() => _AddressLineState();
}

class _AddressLineState extends State<AddressLine> {
  TextEditingController baranggay = new TextEditingController();
  TextEditingController housenumber = new TextEditingController();
  TextEditingController building = new TextEditingController();
  TextEditingController streetname = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    getAddress();
    super.initState();
  }



  getAddress()async{
    final pref =await SharedPreferences.getInstance();
    setState(() {
      baranggay.text =pref.getString("unit_number");
      housenumber.text =pref.getString("house_number");
      building.text =pref.getString("building");
      streetname.text =   pref.getString("street_name");
    });
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Address',
          style: TextStyle(
              fontFamily: "Gildroy-light",
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: eBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: pureblue,
                      controller: baranggay,
                      validator: (value) {
                        if (value.toUpperCase().isEmpty) {
                          return "Required";
                        } else {
                          
                        }
                      },
                      style: TextStyle(
                        color: pureblue,
                        fontFamily: 'Gilroy-light',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.add_to_home_screen,
                          color: pureblue,
                        ),
                        hintText: baranggay.text.isEmpty?'Unit Number' : baranggay.text,
                        hintStyle: eHintStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: eBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: pureblue,
                      controller: housenumber,
                      validator: (value) {
                        if (value.toUpperCase().isEmpty) {
                          return "Required";
                        } else {
                           
                        }
                      },
                      style: TextStyle(
                        color: pureblue,
                        fontFamily: 'Gilroy-light',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.home,
                          color: pureblue,
                        ),
                        hintText: 'House Number',
                        hintStyle: eHintStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: eBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: pureblue,
                      controller: building,
                      validator: (value) {
                        if (value.toUpperCase().isEmpty) {
                          return "Required";
                        } else {
                           
                        }
                      },
                      style: TextStyle(
                        color: pureblue,
                        fontFamily: 'Gilroy-light',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.home,
                          color: pureblue,
                        ),
                        hintText: 'Village/Subdivision',
                        hintStyle: eHintStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: eBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      cursorColor: pureblue,
                      controller: streetname,
                      validator: (value) {
                        if (value.toUpperCase().isEmpty) {
                          return "Required";
                        } else {
                          
                        }
                      },
                      style: TextStyle(
                        color: pureblue,
                        fontFamily: 'Gilroy-light',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.streetview,
                          color: pureblue,
                        ),
                        hintText: 'Street Name',
                        hintStyle: eHintStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width -40,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState.validate()) {
                                  final pref =await SharedPreferences.getInstance();
                                  pref.setString("unit_number", baranggay.text);
                                  pref.setString("house_number", housenumber.text);
                                  pref.setString("building", building.text);
                                  pref.setString("street_name", streetname.text);
                                 
                                    _formkey.currentState.save();
                                 
                                
                                }    
                              },
                              child: Container(
                                height: 60,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

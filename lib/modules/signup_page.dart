import 'dart:convert';
import 'dart:io';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/bara_rang.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/modules/tac/tac_help.dart';
import 'package:WhereTo/modules/tac/terms_condition.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:geolocation/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styletext.dart';
import 'homepage.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
class MyChoice {
  String pickchoice;
  int numberpick;
  MyChoice({this.pickchoice, this.numberpick});
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File _idPickerImage;
  final pick = ImagePicker();
  String stringPath;
  String selectPerson;
  var idbararangSaika;
  var thimagelink;

  final formkey = GlobalKey<FormState>();

  TextEditingController fulname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ownNumber = TextEditingController();
  TextEditingController ownAddress = TextEditingController();
  TextEditingController ownpass = TextEditingController();
  TextEditingController ownconpass = TextEditingController();

  bool loading = false;
  bool isprocess = false;

  phoneValidate(String val) {
    Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
    RegExp regExp = new RegExp(pattern);
    if (val.length == 0) {
      return 'Please enter your number';
    } else if (val.length < 11) {
      return 'Mobile Number Consist of 11 Digits';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter A Valid Contact Number';
    } else {
      return null;
    }
  }

  emailValidate(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget _formRegister(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            // Text(
            //   'Full Name',
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: fulname,
                validator: (val) =>
                    val.isEmpty ? ' Please Put Your Full Name' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: pureblue,
                  ),
                  hintText: 'Full Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Text(
            //   'Email',
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: email,
                validator: (val) => emailValidate(email.text = val),
                onSaved: (val) => email.text = val,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color:pureblue,
                  ),
                  hintText: 'Email',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Text(
            //   "Barangay",
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration: eBoxDecorationStyle,
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButtonHideUnderline(
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.place,
                              color: pureblue,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                "Select Barangay",
                                style: TextStyle(
                                    color: pureblue,
                                    fontFamily: 'Gilroy-light'),
                              ),
                              dropdownColor: Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color:pureblue,
                              ),
                              value: selectPerson,
                              items: dataBarangay.map((item) {
                                return new DropdownMenuItem(
                                  child: Text(
                                    item['barangayName'],
                                    style: TextStyle(
                                        color: pureblue,
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectPerson = item;
                                  idbararangSaika = item;
                                  print(idbararangSaika);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                )),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Text(
            //   "Address",
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  AwesomeDialog(
                      context: context,
                      headerAnimationLoop: false,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      title: "Location",
                      desc: "Get Delivery Address Location",
                      btnOkText: "Get Address",
                      btnOkColor: Color(0xFF0C375B),
                      btnOkOnPress: () async {
                        // var location = Location();
                        // bool _serviceEnabled;
                        // _serviceEnabled = await location.serviceEnabled();
                        // if (!_serviceEnabled) {
                        //   _serviceEnabled = await location.requestService();
                        //   if (!_serviceEnabled) {
                        //     return;
                        //   }
                        // }
                        // PermissionStatus permissionStatus =
                        //     await location.hasPermission();
                        // if (permissionStatus == PermissionStatus.denied) {
                        //   permissionStatus = await location.requestPermission();
                        //   if (permissionStatus != PermissionStatus.granted) {
                        //     return;
                        //   }
                        // }else if(permissionStatus ==PermissionStatus.deniedForever){
                        //   permissionStatus = await location.requestPermission();
                        //   if (permissionStatus != PermissionStatus.granted) {
                        //     return;
                        //   }
                        // }
                        // var userLocation = await location.getLocation();
                        // setState(() {

                        //   ownAddress.text ="${userLocation.latitude},${userLocation.longitude}";
                        // });
                          Position postion =await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          final coordinates =new Coordinates(postion.latitude,postion.longitude);
                          var addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
                          var first =addresses.first;
                          ownAddress.text ="${first.addressLine}";
                      }).show();
                },
                controller: ownAddress,
                validator: (val) =>
                    val.isEmpty ? ' Please Put Your Address' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.my_location,
                    color: pureblue,
                  ),
                  hintText: 'Address',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Text(
            //   'Password',
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: ownpass,
                validator: (input) =>
                    ownpass.text.length < 8 ? 'Password to Short' : null,
                obscureText: true,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: pureblue,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Text(
            //   'Confirm Password',
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: ownconpass,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Input Confirm Password";
                  }
                  if (val != ownpass.text) {
                    return "Password not Match";
                  }
                  return null;
                },
                obscureText: true,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: pureblue,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // Text(
            //   'Contact Number',
            //   style: eLabelStyle,
            // ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                keyboardType: TextInputType.number,
                controller: ownNumber,
                validator: (val) => phoneValidate(ownNumber.text = val),
                onSaved: (val) => ownNumber.text = val,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: pureblue,
                  ),
                  hintText: '09**********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.symmetric(vertical: 25.0),
            //   child: RaisedButton(
            //     onPressed: () {
            //       // _signingIn();
            //     },
            //     elevation: 5.0,
            //     padding: EdgeInsets.all(8.0),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30.0),
            //     ),
            //     color: Colors.white,
            //     child: Text(
            //       loading ? 'Loading....' : 'Register',
            //       style: TextStyle(
            //         color: Color(0xFF527DAA),
            //         letterSpacing: 1.5,
            //         fontSize: 16.0,
            //         fontWeight: FontWeight.bold,
            //         fontFamily: 'Gilroy-light',
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _botDownSignIn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have An Account Already?',
              style: TextStyle(
                color: pureblue,
                fontSize: 14.0,
                fontFamily: 'Gilroy-light'
              ),
            ),
            TextSpan(
              text: 'Sign In Now.',
              style: TextStyle(
                color: pureblue,
                fontSize: 14.0,
                fontFamily: 'Gilroy-ExtraBold'
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    
    this.callBarangay();
    super.initState();
    
  }

  List dataBarangay = List();

  callBarangay() async {
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
      body: WillPopScope(child: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
                 Text(
                            'Sign up',
                            style: TextStyle(
                              color: pureblue,
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                SizedBox(height: 20,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40),
                  child: _formRegister(context),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: GestureDetector(
                   onTap: () => TermsAndConditions.show(context),
                   child: Text("Terms And Conditions.",
                   style: TextStyle(
                     decoration: TextDecoration.underline,
                     color: pureblue,
                     fontSize: 12,
                     fontFamily: 'Gilroy-light'
                   ),
                   ),
                 ),
                          ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: GestureDetector(
                            onTap:
                            _signingIn,
                            child: Container(
                              height: 50,
                              width: 110,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text( loading ? '....' : 'Register <',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            ),
                          ),
                          ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                 _botDownSignIn(),
                 SizedBox(height: 30,),
                 
            ],
          ),
        )),
       onWillPop: () async => false),
    );
  }
  void _signingIn() async {
    setState(() {
      loading = true;
    });

    bool value = true;

    if (selectPerson == null) {
      _showDistictWarning("Select Barangay");
    } else {
      if (formkey.currentState.validate()) {
        formkey.currentState.save();
        var data = {
          'name': fulname.text,
          'email': email.text,
          'contactNumber': ownNumber.text,
          'address': ownAddress.text,
          'password': ownpass.text,
          'barangayId': selectPerson.toString(),          
        };
        var res = await ApiCall().postData(data, '/register');
        var body = json.decode(res.body);
        if (res.statusCode == 200) {
          if (body['success']) {
            var valid = await ApiCall().getUserVerification('/submitVerification/${body['user']['id']}');
            print(valid.body);
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setBool('check', value);
            localStorage.setString('token', body['token']);
            localStorage.setString('user', json.encode(body['user']));
            
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => HomePage()));
          } else {
           
            throw Exception('Failed to Save');
          }
        }else{
           _showDial(body);
        }
      }
    }

    setState(() {
      loading = false;
    });
  }

  void _showDial(String message) {
    showDialog(
    context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
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
              child: Text(
               message,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
    );
  }
  
  void _showDistictWarning(String meesage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
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
              child: Text(
                meesage,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
    );
  }
}

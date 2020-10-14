import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:WhereTo/A1_NewSingleBottomNav/Single_customfield/single.customField.dart';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/AnCustom/getAddress_diloag.dart';
import 'package:WhereTo/AnCustom/pop.dart';
import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/SignupBloc/signupBloc.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/tac/tac_help.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:geolocation/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styletext.dart';
import 'homepage.dart';
import 'package:path/path.dart' as path;
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
  String selectPerson;
  var idbararangSaika;
  var addresses;
  String coordi;
  double lat;
  double lng;
  FocusNode names;
  FocusNode emails;
  FocusNode conacts;
  FocusNode passwords;
  FocusNode conpasswords;
  FocusNode barangaySelect;
  bool loadingShow= false;
  // final formkey = GlobalKey<FormState>();

  // TextEditingController fulname = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController ownNumber = TextEditingController();
  TextEditingController ownAddress = TextEditingController();
  // TextEditingController ownpass = TextEditingController();
  // TextEditingController ownconpass = TextEditingController();

  // bool loading = false;
  // bool isprocess = false;

  // phoneValidate(String val) {
  //   Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (val.length == 0) {
  //     return 'Please enter your number';
  //   } else if (val.length < 11) {
  //     return 'Mobile Number Consist of 11 Digits';
  //   } else if (!regExp.hasMatch(val)) {
  //     return 'Enter A Valid Contact Number';
  //   } else {
  //     return null;
  //   }
  // }

  // emailValidate(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value))
  //     return 'Enter Valid Email';
  //   else
  //     return null;
  // }

   Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
 Widget _loading(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }

Widget _view(BaranggayRespone respone,SignUpBlocDick signUpBlocDick){
    List<Barangays> bararangs = respone.bararangSaika;
    if(bararangs.length == 0 ){
          return Container(
            child: Text('Come Back Later.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{

             
            //    
             return Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ),
              ),
              child: Padding(
               padding: const EdgeInsets.only(left: 10),
               child: DropdownButtonHideUnderline(
                 child: Stack(
                   children: [
                     Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Icon(
                                Icons.place,
                                color: Color(0xFF0F75BB),
                              ),
                            )),
                    Padding(
                       padding: const EdgeInsets.only(left: 30),
                       child: ButtonTheme(
                         alignedDropdown: true,
                         child: StreamBuilder(
                           stream: signUpBlocDick.barangayId,
                           builder: (context, snaps){
                             return   DropdownButton<String>(
                               focusNode: barangaySelect,
                             isExpanded: true,
                             hint:  Text(
                                    "Select Barangay",
                                    style: TextStyle(
                                        color: Color(0xFF0F75BB),
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                   dropdownColor: Colors.white,
                                   icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:Color(0xFF0F75BB),
                                  ),
                                
                             items: bararangs.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.barangayName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value:snaps.data,
                               
                             onChanged: (val){
                               signUpBlocDick.changebarangayId(val);
                             },
                             );
                           },
                          
                         ),
                       ),
                      ),        
                   ],
                 ),
               ),
                ),
                );
        }
  }


  // Widget _formRegister(BuildContext context) {
  //   return Form(
  //     key: formkey,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         // crossAxisAlignment: CrossAxisAlignment.start,
  //         // textDirection: TextDirection.ltr,
  //         children: <Widget>[
  //           _getImage(),
  //                   SizedBox(height: 15,),
  //                 Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   child: Stack(
  //                     children: <Widget>
  //                     [
  //                        Align(
  //                         alignment: Alignment.topLeft,
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 70),
  //                           child: GestureDetector(
  //                             onTap: (){
  //                               getYourIdImage(ImageSource.camera);
  //                             }, 
  //                             child: Container(
  //                               height: 40,
  //                               width: 40,
  //                               decoration: BoxDecoration(
  //                                 color: pureblue,
  //                                 borderRadius: BorderRadius.all(Radius.circular(100)),
  //                               ),
  //                               child: Center(
  //                                child: Icon(Icons.camera,
  //                                size: 20,
  //                                color: Colors.white
  //                                ),
  //                               ),
  //                             ),
  //                           ),
  //                           ),
  //                       ),
  //                       Align(
  //                         alignment: Alignment.topRight,
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(right: 70),
  //                           child: GestureDetector(
  //                             onTap: (){
  //                               getYourIdImage(ImageSource.gallery);
  //                             }, 
  //                             child: Container(
  //                               height: 40,
  //                               width: 40,
  //                               decoration: BoxDecoration(
  //                                 color: pureblue,
  //                                 borderRadius: BorderRadius.all(Radius.circular(100)),
  //                               ),
  //                               child: Center(
  //                                child: Icon(Icons.picture_in_picture,
  //                                size: 20,
  //                                color: Colors.white
  //                                ),
  //                               ),
  //                             ),
  //                           ),
  //                           ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height:15,),
  //           // Text(
  //           //   'Full Name',
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               cursorColor: pureblue,
  //               controller: fulname,
  //               validator: (val) =>
  //                   val.isEmpty ? ' Please Put Your Full Name' : null,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.person,
  //                   color: pureblue,
  //                 ),
  //                 hintText: 'Full Name',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 10.0,
  //           // ),
  //           // Text(
  //           //   'Email',
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               cursorColor: pureblue,
  //               controller: email,
  //               validator: (val) => emailValidate(email.text = val),
  //               onSaved: (val) => email.text = val,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.email,
  //                   color:pureblue,
  //                 ),
  //                 hintText: 'Email',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 15.0,
  //           // ),
  //           // Text(
  //           //   "Barangay",
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),

  //           StreamBuilder<BaranggayRespone>(
  //     stream: bararangStream.subject.stream,
  //     builder: (context,AsyncSnapshot<BaranggayRespone> snaphot){
  //        if(snaphot.hasData){
  //           if(snaphot.data.error !=null && snaphot.data.error.length > 0){
  //               return _errorTempMessage(snaphot.data.error);
  //           }
  //             return _view(snaphot.data);
  //       }else if(snaphot.hasError){
  //             return _errorTempMessage(snaphot.error);
  //       }else{
  //             return _loading();
  //       }
      
  //     }),
  //           // Container(
  //           //     width: MediaQuery.of(context).size.width,
  //           //     alignment: Alignment.centerLeft,
  //           //     decoration: eBoxDecorationStyle,
  //           //     height: 50.0,
  //           //     child: Padding(
  //           //       padding: const EdgeInsets.only(left: 10),
  //           //       child: DropdownButtonHideUnderline(
  //           //         child: Stack(
  //           //           children: <Widget>[
  //           //             Align(
  //           //                 alignment: Alignment.centerLeft,
  //           //                 child: Icon(
  //           //                   Icons.place,
  //           //                   color: pureblue,
  //           //                 )),
  //           //             Padding(
  //           //               padding: const EdgeInsets.only(left: 30),
  //           //               child: DropdownButton(
  //           //                   isExpanded: true,
  //           //                   hint: Text(
  //           //                     "Select Barangay",
  //           //                     style: TextStyle(
  //           //                         color: pureblue,
  //           //                         fontFamily: 'Gilroy-light'),
  //           //                   ),
  //           //                   dropdownColor: Colors.white,
  //           //                   icon: Icon(
  //           //                     Icons.arrow_drop_down,
  //           //                     color:pureblue,
  //           //                   ),
  //           //                   value: selectPerson,
  //           //                   items: dataBarangay.map((item) {
  //           //                     return new DropdownMenuItem(
  //           //                       child: Text(
  //           //                         item['barangayName'],
  //           //                         style: TextStyle(
  //           //                             color: pureblue,
  //           //                             fontFamily: 'Gilroy-light'),
  //           //                       ),
  //           //                       value: item['id'].toString(),
  //           //                     );
  //           //                   }).toList(),
  //           //                   onChanged: (item) {
  //           //                     setState(() {
  //           //                       selectPerson = item;
  //           //                       idbararangSaika = item;
  //           //                       print(idbararangSaika);
  //           //                     });
  //           //                   }),
  //           //             ),
  //           //           ],
  //           //         ),
  //           //       ),
  //           //     )),

  //           // SizedBox(
  //           //   height: 15.0,
  //           // ),
  //           // Text(
  //           //   "Address",
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               readOnly: true,
  //               onTap: () async {
  //                  Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //                         final coordinates =new Coordinates(postion.latitude,postion.longitude);
  //                         setState(() {
  //                           // coordi ="${postion.latitude},${postion.longitude}";
  //                           lat =postion.latitude;
  //                           lng =postion.longitude;
  //                         });
  //                         addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //                         var first =addresses.first;
  //                         ownAddress.text ="${first.addressLine}";
  //                 // AwesomeDialog(
  //                 //     context: context,
  //                 //     headerAnimationLoop: false,
  //                 //     animType: AnimType.SCALE,
  //                 //     dialogType: DialogType.INFO,
  //                 //     title: "Location",
  //                 //     desc: "Get Delivery Address Location",
  //                 //     btnOkText: "Get Address",
  //                 //     btnOkColor: Color(0xFF0C375B),
  //                 //     btnOkOnPress: () async {
  //                 //       // var location = Location();
  //                 //       // bool _serviceEnabled;
  //                 //       // _serviceEnabled = await location.serviceEnabled();
  //                 //       // if (!_serviceEnabled) {
  //                 //       //   _serviceEnabled = await location.requestService();
  //                 //       //   if (!_serviceEnabled) {
  //                 //       //     return;
  //                 //       //   }
  //                 //       // }
  //                 //       // PermissionStatus permissionStatus =
  //                 //       //     await location.hasPermission();
  //                 //       // if (permissionStatus == PermissionStatus.denied) {
  //                 //       //   permissionStatus = await location.requestPermission();
  //                 //       //   if (permissionStatus != PermissionStatus.granted) {
  //                 //       //     return;
  //                 //       //   }
  //                 //       // }else if(permissionStatus ==PermissionStatus.deniedForever){
  //                 //       //   permissionStatus = await location.requestPermission();
  //                 //       //   if (permissionStatus != PermissionStatus.granted) {
  //                 //       //     return;
  //                 //       //   }
  //                 //       // }
  //                 //       // var userLocation = await location.getLocation();
  //                 //       // setState(() {

  //                 //       //   ownAddress.text ="${userLocation.latitude},${userLocation.longitude}";
  //                 //       // });
                         
  //                 //     }).show();
  //               },
  //               controller: ownAddress,
  //               validator: (val) =>
  //                   val.isEmpty ? ' Please Put Your Address' : null,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.my_location,
  //                   color: pureblue,
  //                 ),
  //                 hintText: 'Get Address Automatically',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 15.0,
  //           // ),
  //           // Text(
  //           //   'Password',
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               cursorColor: pureblue,
  //               controller: ownpass,
  //               validator: (input) =>
  //                   ownpass.text.length < 8 ? 'Password to Short' : null,
  //               obscureText: true,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.lock,
  //                   color: pureblue,
  //                 ),
  //                 hintText: 'Password',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 15.0,
  //           // ),
  //           // Text(
  //           //   'Confirm Password',
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               cursorColor: pureblue,
  //               controller: ownconpass,
  //               validator: (val) {
  //                 if (val.isEmpty) {
  //                   return "Please Input Confirm Password";
  //                 }
  //                 if (val != ownpass.text) {
  //                   return "Password not Match";
  //                 }
  //                 return null;
  //               },
  //               obscureText: true,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.lock,
  //                   color: pureblue,
  //                 ),
  //                 hintText: 'Confirm Paswword',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 15.0,
  //           // ),
  //           // Text(
  //           //   'Contact Number',
  //           //   style: eLabelStyle,
  //           // ),
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             alignment: Alignment.centerLeft,
  //             decoration: eBoxDecorationStyle,
  //             height: 50.0,
  //             child: TextFormField(
  //               cursorColor: pureblue,
  //               keyboardType: TextInputType.number,
  //               controller: ownNumber,
  //               validator: (val) => phoneValidate(ownNumber.text = val),
  //               onSaved: (val) => ownNumber.text = val,
  //               style: TextStyle(
  //                 color: pureblue,
  //                 fontFamily: 'Gilroy-light',
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14.0),
  //                 prefixIcon: Icon(
  //                   Icons.phone_android,
  //                   color: pureblue,
  //                 ),
  //                 hintText: 'Contact Number',
  //                 hintStyle: eHintStyle,
  //               ),
  //             ),
  //           ),
  //           // SizedBox(
  //           //   height: 10.0,
  //           // ),
  //           // Container(
  //           //   width: MediaQuery.of(context).size.width,
  //           //   padding: EdgeInsets.symmetric(vertical: 25.0),
  //           //   child: RaisedButton(
  //           //     onPressed: () {
  //           //       // _signingIn();
  //           //     },
  //           //     elevation: 5.0,
  //           //     padding: EdgeInsets.all(8.0),
  //           //     shape: RoundedRectangleBorder(
  //           //       borderRadius: BorderRadius.circular(30.0),
  //           //     ),
  //           //     color: Colors.white,
  //           //     child: Text(
  //           //       loading ? 'Loading....' : 'Register',
  //           //       style: TextStyle(
  //           //         color: Color(0xFF527DAA),
  //           //         letterSpacing: 1.5,
  //           //         fontSize: 16.0,
  //           //         fontWeight: FontWeight.bold,
  //           //         fontFamily: 'Gilroy-light',
  //           //       ),
  //           //     ),
  //           //   ),
  //           // ),
  //           SizedBox(height: 20,),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Stack(
  //                   children: <Widget>
  //                   [
  //                     Align(
  //                       alignment: Alignment.topLeft,
  //                         child: GestureDetector(
  //                  onTap: () => TermsAndConditions.show(context),
  //                  child: Text("Terms And Conditions.",
  //                  style: TextStyle(
  //                    decoration: TextDecoration.underline,
  //                    color: pureblue,
  //                    fontSize: 12,
  //                    fontFamily: 'Gilroy-light'
  //                  ),
  //                  ),
  //                ),
  //                     ),
  //                     Align(
  //                       alignment: Alignment.topRight,
  //                         child: GestureDetector(
  //                           onTap:
  //                           _signingIn,
  //                           child: Container(
  //                             height: 50,
  //                             width: 110,
  //                             decoration: BoxDecoration(
  //                               color: pureblue,
  //                               borderRadius: BorderRadius.all(Radius.circular(100)),
  //                             ),
  //                             child: Center(
  //                               child: Text( loading ? '....' : 'Register <',
  //                               style: TextStyle(
  //                                 fontFamily: 'Gilroy-ExtraBold',
  //                                 fontSize: 18,
  //                                 color: Colors.white
  //                               ),
  //                               ),
  //                             ),
  //                           ),
                          
  //                         ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
     configSignal();
    // callBarangay();
    super.initState();
    bararangStream..getBarangayListFormDb();
      names = FocusNode();
  emails =  FocusNode();
   conacts = FocusNode();
   passwords = FocusNode();
  conpasswords = FocusNode();
  barangaySelect= FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    bararangStream..drainStreamData();
  }

  void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
}
  

  // List<dynamic> dataBarangay = List();

  // callBarangay() async {
  //   var respon = await ApiCall().getBararang('/getBarangayList');
  //   var bararang = json.decode(respon.body);

  //   setState(() {
  //     dataBarangay = bararang;
  //   });
  //   // print(bararang);
  // }


  
//   void openLogAddrs(){

//      showGeneralDialog(context: context,
//                   barrierDismissible: true,
//                   barrierLabel: '',
//                   transitionDuration: Duration(milliseconds: 300),
//                   transitionBuilder: (context,_animation,_secondary,_child){
//                     return MicoPops.grows(_animation, _secondary, _child);
//                   },
//                   pageBuilder: (_animation,_secondary,_child){
//                     return  BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
//       child: Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
//         elevation: 0,
//         backgroundColor: pureblue,
//         child: Container(
//           height: 300,
//           decoration: BoxDecoration(
//             color: Color(0xFFF2F2F2),
//             borderRadius: BorderRadius.all(Radius.circular(50))
//           ),
//           child: Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: 10,),
//               Text("Delivery Address?",
//               maxLines: 2,
//               style: TextStyle(
//                 fontFamily: 'Gilroy-light',
//                 fontSize: 16,
//                 color: pureblue
//               ),
//               ),
//               SizedBox(height: 120,),
//               GestureDetector(
//                 onTap: () async{
//                   Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//                           final coordinates =new Coordinates(postion.latitude,postion.longitude);
//                           addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
//                           var first =addresses.first;
//                           ownAddress.text ="${first.addressLine}";
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 130,
//                   decoration: BoxDecoration(
//                     color: pureblue,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Icon(
//                           Icons.my_location,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                         Text("Get Address",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Gilroy-light',
//                           fontSize: 12
//                         ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )

//             ],
//           ),
//           ),
//         ),
//       ),
//     );
//                   }
//                   );  

//   }

  final pick = ImagePicker();
   File _idPickerImage;
   String stringPath;
   var thimagelink;

getYourIdImage( ImageSource source) async{

    var imageIdValid = await pick.getImage(source: source); 
       File crop = await ImageCropper.cropImage(
      sourcePath: imageIdValid != null ? imageIdValid.path : null,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Where To Id Cropper',
          toolbarColor: pureblue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ) );
    setState(() {
      _idPickerImage = crop;
      
      // print(imageIdValid.path);
    });
    

  }
 Widget _getImage(){
    if(_idPickerImage != null){
      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Image.file(
              _idPickerImage,
              fit: BoxFit.cover,
        ),
      );
    }else{
        return Container(
          width: 80,
        height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pureblue
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
    }

  }  

//  Widget loadingSpring() {

//    return Container(
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
//      child: Center(
//         child: SpinKitCubeGrid(
//           color: pureblue,
//           size: 80.0,
//         )
//      ),
//    );


//  }  

  


  Widget fullname(SignUpBlocDick signUpBlocDick){
    return CustomTextFieldFixStyle(
      stream: signUpBlocDick.name,
      obsecure: false,
      onchangeTxt: signUpBlocDick.changeName,
      iconText: EvaIcons.person,
      type: TextInputType.name,
      hintTxt: "Full Name",
      labelText: "Full Name",
      nodes: names ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(emails),
    );
  }
  Widget email(SignUpBlocDick signUpBlocDick){
    return CustomTextFieldFixStyle(
      stream: signUpBlocDick.email,
      obsecure: false,
      onchangeTxt: signUpBlocDick.changeEmail,
      iconText: EvaIcons.email,
      type: TextInputType.emailAddress,
      hintTxt: "whereto@example.com",
      labelText: "Email",
      nodes: emails ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(conacts),
    );
  }
  Widget phone(SignUpBlocDick signUpBlocDick){
    return CustomTextFieldFixStyle(
      stream: signUpBlocDick.xcontactNumber,
      obsecure: false,
      onchangeTxt: signUpBlocDick.changeContactNumber,
      iconText: EvaIcons.email,
      type: TextInputType.number,
      hintTxt: "09XXXXXXXXX",
      labelText: "Contact Number",
      nodes: conacts ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(passwords),
    );
  }
  bool show = true;
  Widget pass(SignUpBlocDick signUpBlocDick){
    return Stack(
      children: [
        CustomTextFieldFixStyle(
      stream: signUpBlocDick.password,
      obsecure: show,
      onchangeTxt: signUpBlocDick.changePassword,
      iconText: Icons.lock,
      hintTxt: "Password",
      nodes: passwords,
      labelText: "Password",
      actions: TextInputAction.next,
      submit: (_) => FocusScope.of(context).requestFocus(conpasswords),
    ),
         Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25,top: 15),
                      child: GestureDetector(
                        onTap: () => setState(() => show = !show),
                        child: Icon(
                          show ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: Color(0xFF0F75BB),
                        ),
                      ),
                      ),
                  ),

      ],
    );
  }
  Widget conpass(SignUpBlocDick signUpBlocDick){
    return Stack(
      children: [
        CustomTextFieldFixStyle(
      stream: signUpBlocDick.confirmpasswords,
      obsecure: show,
      onchangeTxt: signUpBlocDick.changeConfirmPassword,
      iconText: Icons.lock,
      hintTxt: "Confirm Password",
      nodes: conpasswords,
      labelText: "Confirm Password",
      actions: TextInputAction.next,
      submit: (_) => FocusScope.of(context).requestFocus(barangaySelect),
    ),
         Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25,top: 15),
                      child: GestureDetector(
                        onTap: () => setState(() => show = !show),
                        child: Icon(
                          show ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: Color(0xFF0F75BB),
                        ),
                      ),
                      ),
                  ),

      ],
    );
  }
  Widget barangay(){
    return StreamBuilder<BaranggayRespone>(
      stream: bararangStream.subject.stream,
      builder: (context,AsyncSnapshot<BaranggayRespone> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _view(snaphot.data,signUpBlocDicks);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }
  Widget formButt(SignUpBlocDick signUpBlocDick){
    return StreamBuilder(
      stream: signUpBlocDick.submiited,
      builder: (context, snaps) 
      => Container(
        height: 50,
        width: 150,
        child: RaisedButton(
          color: pureblue,
          splashColor: wheretoDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60)
          ),
          child:Center(
                            child: Text("Sign Up ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy-light'
                            ),
                            ), 
                        ),
          onPressed: snaps.hasData
          ?() => navigatepage(signUpBlocDick):null),
      ));
  }

  void navigatepage(SignUpBlocDick signUpBlocDick) async{

    if(_idPickerImage == null){
       showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Please Select an Image.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else 
    if(ownAddress.text.isEmpty){
       showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Please Click the Auto Getter Address and please make Location on Phone On.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else{
      setState(() {
        loadingShow = true;
      });
         var viewthis = path.basename(_idPickerImage.path);
                            CloudinaryClient client = new CloudinaryClient(
                              "822285642732717",
                              "6k0dMMg3As30mPmjeWLeFL5-qQ4",
                              "amadpogi");
       await client.uploadImage( _idPickerImage.path ,filename: "Profile/$viewthis") .then((result){
                                stringPath = result.secure_url;
                                  print(stringPath);
                                  thimagelink = stringPath;
                              })
                              .catchError((error) => print("ERROR_CLOUDINARY::  $error"));

    await signUpBlocDick.signUpUser(thimagelink,lat, lng,context);
    await signUpBlocDick.dispose();
     setState(() {
       loadingShow = false;
     }); 
    }
  }

Widget spinKitDots(){
  return Container(
    height: 40,
    width: 60,
    child: SpinKitThreeBounce(
      color: pureblue,
      size: 30,
    ),
  );
}
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: WillPopScope(child: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: 
          // loading ?  loadingSpring() :
          Padding(
            padding: const EdgeInsets.only(left: 40,right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(height: 20,),
                      _getImage(),
                      SizedBox(height: 15,),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 40,
                              width: 120,
                              child: RaisedButton(
                                splashColor: Colors.white,
                                color: pureblue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                child: Center(
                                  child: Text(
                              'Camera',
                              style: TextStyle(
                               color: Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ) ,
                                ),
                                onPressed:()=> getYourIdImage(ImageSource.camera) ),
                            ),
                             Container(
                              height: 40,
                              width: 120,
                              child: RaisedButton(
                                splashColor: Colors.white,
                                color: pureblue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                child: Center(
                                  child: Text(
                              'Gallery',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ) ,
                                ),
                                onPressed:()=> getYourIdImage(ImageSource.gallery) ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(height:25,),
                    fullname(signUpBlocDicks),
                    SizedBox(height: 15,),
                    email(signUpBlocDicks),
                    SizedBox(height: 15,),
                    phone(signUpBlocDicks),
                    SizedBox(height: 15,),
                    pass(signUpBlocDicks),
                    SizedBox(height: 15,),
                    conpass(signUpBlocDicks),
                     SizedBox(height: 15,),
                     barangay(),
                     SizedBox(height: 15,),
              Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
            decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ),
              ),
              height: 55.0,
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                   Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          final coordinates =new Coordinates(postion.latitude,postion.longitude);
                          setState(() {
                            // coordi ="${postion.latitude},${postion.longitude}";
                            lat =postion.latitude;
                            lng =postion.longitude;
                          });
                          addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
                          var first =addresses.first;
                          ownAddress.text ="${first.addressLine}";
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
                  hintText: 'Get Address Automatically',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
               SizedBox(height: 15,),
                loadingShow ? spinKitDots() :
                formButt(signUpBlocDicks),
                SizedBox(height: 25,),
              ],
            ),
          ),
        )),
       onWillPop: () async => false),
       bottomNavigationBar: Container(
         height: 40,
         width: MediaQuery.of(context).size.width,
         child: Center(
           child: _botDownSignIn(),
         ),
       ),
    );
  }
//   void _signingIn() async {
//     var coordinates =await ID().getPosition();
//     setState(() {
//       loading = true;
//     });

//     bool value = true;

//     if (selectPerson == null) {
//       _showDistictWarning("Select Barangay");
//     }else if(_idPickerImage == null){
//       _showDistictWarning("Please Select your Profile Image. ");
//     }else {
//       var viewthis = path.basename(_idPickerImage.path);
//                             CloudinaryClient client = new CloudinaryClient(
//                               "822285642732717",
//                               "6k0dMMg3As30mPmjeWLeFL5-qQ4",
//                               "amadpogi");
//       if (formkey.currentState.validate()) {
//         formkey.currentState.save();
          
//                             await client.uploadImage( _idPickerImage.path ,filename: "Profile/$viewthis") .then((result){
//                                 stringPath = result.secure_url;
//                                   print(stringPath);
//                                   thimagelink = stringPath;
//                               })
//                               .catchError((error) => print("ERROR_CLOUDINARY::  $error"));
//         var data = {
//           'name': fulname.text,
//           'email': email.text,
//           'contactNumber': ownNumber.text,
//           'latitude': lat,
//           'longitude': lng,
//           'password': ownpass.text,
//           'barangayId': selectPerson.toString(),
//           'imagePath': thimagelink         
//         };
//         var res = await ApiCall().postData(data, '/register');
//         var body = json.decode(res.body);
//         if (res.statusCode == 200) {
//           if (body['success']) {
//              SharedPreferences localStorage =await SharedPreferences.getInstance();
//             localStorage.setBool('check', value);
//             localStorage.setString('token', body['token']);
//             localStorage.setString('trial','trialShow');
//             localStorage.setString('user', json.encode(body['user']));
//             localStorage.setString("coordinates", coordi);
//             localStorage.setString("userTYPO", body['userType'].toString());
//             localStorage.setDouble("latitude", lat);
//             localStorage.setDouble("longitude", lng);
//              authShared.saveDataAccount(
//           body['token'],
//           body['user']['userType'].toString(),
//           body['user']['latitude'].toString(),
//           body['user']['longitude'].toString());

//           authShared.userTypeScreen(context,
//         body['user']['userType'],);
//             var valid = await ApiCall().getUserVerification('/submitVerification/${body['user']['id']}');
//             print(valid.body);
//             Navigator.pushReplacement(context,
//                 new MaterialPageRoute(builder: (context) => HomePage()));
//           } else {
//             _showDial("Failed to Save");
//             throw Exception('Failed to Save');
           
//           }
//         }else{
//            _showDial(body);
//         }
//       }
//     }

//     setState(() {
//       loading = false;
//     });
//   }

//   void showProg(bool load) {

    

//   }

  // void _showDial(String message) {
  //   showDialog(
  //   context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child:Container(
  //     height: 300.0,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20), color: Colors.white),
  //     child: SingleChildScrollView(
  //       physics: AlwaysScrollableScrollPhysics(),
  //       child: Column(
  //         children: <Widget>[
  //           Stack(
  //             children: <Widget>[
  //               Container(
  //                 height: 150.0,
  //               ),
  //               Container(
  //                 height: 150.0,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     topRight: Radius.circular(10),
  //                   ),
  //                   gradient: LinearGradient(
  //                       stops: [0.2, 4],
  //                       colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
  //                       begin: Alignment.topRight,
  //                       end: Alignment.bottomLeft),
  //                 ),
  //               ),
  //               Align(
  //                     alignment: Alignment.center,
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(top: 40),
  //                       child: Container(
  //                         height: 90,
  //                         width: 90,
  //                         padding: EdgeInsets.all(10.0),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(45),
                            
  //                           // border: Border.all(
  //                           //   color: Colors.white,
  //                           //   style: BorderStyle.solid,
  //                           //   width: 2.0,
  //                           // ),
  //                           image: DecorationImage(
  //                             image: AssetImage("asset/img/logo.png"),
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Text(
  //              message,
  //               style: TextStyle(
  //                   color: Color(0xFF0C375B),
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 11.0,
  //                   fontFamily: 'Gilroy-light'),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25.0,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               RaisedButton(
  //                 color: Color(0xFF0C375B),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(30.0)),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   "Ok",
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 12.0,
  //                       fontFamily: 'OpenSans'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //       );
  //     },
  //   );
  // }
  
  // void _showDistictWarning(String meesage) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child:Container(
  //     height: 300.0,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20), color: Colors.white),
  //     child: SingleChildScrollView(
  //       physics: AlwaysScrollableScrollPhysics(),
  //       child: Column(
  //         children: <Widget>[
  //           Stack(
  //             children: <Widget>[
  //               Container(
  //                 height: 150.0,
  //               ),
  //               Container(
  //                 height: 150.0,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     topRight: Radius.circular(10),
  //                   ),
  //                   gradient: LinearGradient(
  //                       stops: [0.2, 4],
  //                       colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
  //                       begin: Alignment.topRight,
  //                       end: Alignment.bottomLeft),
  //                 ),
  //               ),
  //               Align(
  //                     alignment: Alignment.center,
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(top: 40),
  //                       child: Container(
  //                         height: 90,
  //                         width: 90,
  //                         padding: EdgeInsets.all(10.0),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(45),
                            
  //                           // border: Border.all(
  //                           //   color: Colors.white,
  //                           //   style: BorderStyle.solid,
  //                           //   width: 2.0,
  //                           // ),
  //                           image: DecorationImage(
  //                             image: AssetImage("asset/img/logo.png"),
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Text(
  //               meesage,
  //               style: TextStyle(
  //                   color: Color(0xFF0C375B),
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 20.0,
  //                   fontFamily: 'Gilroy-light'),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25.0,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               RaisedButton(
  //                 color: Color(0xFF0C375B),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(30.0)),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   "Ok",
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 12.0,
  //                       fontFamily: 'OpenSans'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //       );
  //     },
  //   );
  // }
}

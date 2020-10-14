
import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/admin_addmenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';

import '../../styletext.dart';

class AddrestuarantAdminSide extends Object with Validators{

final ownername = BehaviorSubject<String>();
final respresentative = BehaviorSubject<String>();
final restaurantName = BehaviorSubject<String>();
final phoneNumber = BehaviorSubject<String>();
final baranggayId = BehaviorSubject<String>();
final cityId = BehaviorSubject<String>();
final opentime = BehaviorSubject<String>();
final closetime = BehaviorSubject<String>();
final closeOnWeek = BehaviorSubject<String>();


Stream<String> get owner => ownername.stream.transform(validTextinput);
Stream<String> get vice => respresentative.stream.transform(validTextinput);
Stream<String> get restauname => restaurantName.stream.transform(validTextinput);
Stream<String> get phone => phoneNumber.stream.transform(validatePhoneNumberuser);
Stream<String> get baranggayID => baranggayId.stream;
Stream<String> get cityID => cityId.stream;
Stream<String> get openTimeRes => opentime.stream;
Stream<String> get closeTimeRes => closetime.stream;
Stream<String> get closeOnWeekRes => closeOnWeek.stream;


Function(String) get changeOwner => ownername.sink.add;
Function(String) get changeVice => respresentative.sink.add;
Function(String) get changeResname => restaurantName.sink.add;
Function(String) get changePhones =>  phoneNumber.sink.add;
Function(String) get changebaran => baranggayId.sink.add;
Function(String) get changeCity => cityId.sink.add;
Function(String) get changeopen => opentime.sink.add;
Function(String) get changeclose => closetime.sink.add;
Function(String) get changeWeek => closeOnWeek.sink.add;

Stream<bool> get submitAll => Rx.combineLatest9(
  owner, 
  vice, 
  restauname, 
  phone, 
  baranggayID, 
  cityID, 
  openTimeRes, 
  closeTimeRes, 
  closeOnWeekRes, 
  (a, b, c, d, e, f, g, h, i) => true);


  addrestaurantOnDB(BuildContext context,String file,String lats,String longs,String feature) async{

    final owname = ownername.value;
    final resname = respresentative.value;
    final restau = restaurantName.value;
    final cNumber = phoneNumber.value;
    final barangid = baranggayId.value;
    final city = cityId.value;
    final open = opentime.value;
    final close = closetime.value;
    final closeWeek = closeOnWeek.value;

    var data = {
                "restaurantName": restau,
                "latitude": lats.toString(),
                "longitude": longs.toString(),
                "barangayId": barangid, 
                "contactNumber": cNumber,
                "cityId":city,
                "openTime": open, 
                "closingTime": close,
                "closeOn": closeWeek,
                "isFeatured": feature,
                "owner": owname,
                "representative" : resname,
                "imagePath":file
                };
    var response = await ApiCall().addRestaurant(data, '/addRestaurant');            
    var body = json.decode(response.body);
    UserGetPref().restuaddForAdmin(body.toString());
    UserGetPref().restuNameExtra(restau);
    showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(
        color: wheretoDark,
        size: 80,),
        labelHeader: "Notice:",
        message: "ID is $body",
        buttTitle1: "OK",
        buttTitle2: "BACK",
        noFunc: ()=>Navigator.pop(context),
        yesFunc: () =>Navigator.pushReplacement(  
            context,
            new MaterialPageRoute(
            builder: (context) => AddmenuAdmin(id: body.toString() ))),
        showorNot1: true,
        showorNot2: true,
      ),
      
      );
  }

 dispose(){
   ownername?.close();
   respresentative?.close();
   restaurantName?.close();
   phoneNumber?.close();
   baranggayId?.close();
   cityId?.close();
   opentime?.close();
   closetime?.close();
   closeOnWeek?.close();
 } 

}

final  addrestuarantAdminSide = AddrestuarantAdminSide();
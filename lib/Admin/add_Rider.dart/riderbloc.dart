

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';

import '../../styletext.dart';

class RiderBloc extends Object with Validators{

  final fullnameRider = BehaviorSubject<String>();
  final emailRider = BehaviorSubject<String>();
  final contactRider = BehaviorSubject<String>();
  final licenseRider = BehaviorSubject<String>();
  final plateRider = BehaviorSubject<String>();
  final baranggayRider = BehaviorSubject<String>();

  Stream<String> get fr =>fullnameRider.stream.transform(validTextinput);
  Stream<String> get em =>emailRider.stream.transform(validateEmail);
  Stream<String> get cr =>contactRider.stream.transform(validatePhoneNumberuser);
  Stream<String> get lr =>licenseRider.stream.transform(validTextinput);
  Stream<String> get pr =>plateRider.stream.transform(validTextinput);
  Stream<String> get br =>baranggayRider.stream;

  // Stream<bool> get sub => Rx.combineLatest6(
  //   fr,em,cr,lr,pr,br,(a,b,c,d,e,f) => true
  // );

  Stream<bool> get subs => Rx.combineLatest6(
    fr, em, cr, lr, pr, br, (a, b, c, d, e, f) => true);

  Function(String) get cfr => fullnameRider.sink.add;
  Function(String) get cem => emailRider.sink.add;
  Function(String) get ccr => contactRider.sink.add;
  Function(String) get clr => licenseRider.sink.add;
  Function(String) get cpr => plateRider.sink.add;
  Function(String) get cbr => baranggayRider.sink.add;
  
  signUpRider(double lat,double lng,BuildContext context) async{
    final ffr = fullnameRider.value;
    final fem = emailRider.value;
    final fcr = contactRider.value;
    final flr = licenseRider.value;
    final fpr = plateRider.value;
    final fbr = baranggayRider.value;

    var data = {
            "name" : ffr,
            "email" : fem,
            "contactNumber" : fcr,
            "latitude": lat.toString(),
            "longitude": lng.toString(),
            "barangayId": fbr,
            "licenseNumber": flr,
            "plateNumber": fpr 
    };

    await ApiCall().addRider(data, '/addRider'); 
    showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Rider is Added",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
  }



  dispose(){
    fullnameRider?.close();
    emailRider?.close();
    contactRider?.close();
    licenseRider?.close();
    plateRider?.close();
    baranggayRider?.close();
  }

  

}
final riderBloc = RiderBloc();
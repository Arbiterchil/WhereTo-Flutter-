import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/A_RiderLog/rider_logPen.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';

import '../../styletext.dart';

class LoginBloc extends Object with Validators{

final contactNumberController = BehaviorSubject<String>();
final passwordController = BehaviorSubject<String>();


Stream<String> get numberPhone => contactNumberController.stream.transform(validatePhoneNumberuser);
Stream<String> get passwordUser => passwordController.stream.transform(validTextinput);
Stream<bool> get submitDatauser => Rx.combineLatest2(numberPhone, passwordUser, (a, b) => true);

Function(String) get changeNumber => contactNumberController.sink.add;
Function(String) get changPassword => passwordController.sink.add;

loginUser(BuildContext context) async{

  final numberUser = contactNumberController.value;
  final passwordUser = passwordController.value;

  if(numberUser != "" && passwordUser != ""){
    var data ={
       'contactNumber': numberUser,
       'password': passwordUser
    };

    var response = await ApiCall().postData(data,'/login');
    var resultBody = json.decode(response.body);
    if(resultBody['success'] == true){
      var check = await ApiCall().logVerify('/isAccountSuspended/${resultBody['user']['id']}');
      if(check.body == "true"){
        showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Account Terminated!",
        message: "This Account Violate our Terms and Conditions.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
      }else{
        
        UserGetPref().setuserJson(json.encode(resultBody['user']));
        UserGetPref().savePassforAll(passwordUser);
        authShared.saveDataAccount(
          resultBody['token'],
          resultBody['user']['userType'].toString(),
          resultBody['user']['latitude'].toString(),
          resultBody['user']['longitude'].toString());
        authShared.userTypeScreen(context,
        resultBody['user']['userType']);

      }
    }else if(resultBody['remitPending'] == true){
      showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "You Have A Pending Remit!",
        message: "Please Remit and Wait for the Admin to Accept.",
        buttTitle1: "OK",
        buttTitle2: "NO",
        noFunc: () =>Navigator.pop(context),
        yesFunc: () => Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => RemitPendingUser(id:  resultBody['user']['id'],))),
        showorNot1: true,
        showorNot2: true,
      ),
      );
    }else if(resultBody['suspended'] == true){
           showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "You Are Suspended for Now.",
        message: "Please Go to Office to Clarify the Situation.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else{
      showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Password Or Contact Number Not Match!",
        message: "Please Check again your Password and Contact Number.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }

  }

}

 dispose(){
  contactNumberController.close();
  passwordController.close();  
}
  forSure(){
    contactNumberController.value = "";
  passwordController.value = "";
  }

}

final  loginBloc = LoginBloc();
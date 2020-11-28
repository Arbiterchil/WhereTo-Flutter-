
import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBlocDick extends Object with Validators{

 final emailControlDicky = BehaviorSubject<String>();
 final nameControlDicky = BehaviorSubject<String>();
 final passwordControlDicky = BehaviorSubject<String>();
 final contactNumberControlDicky = BehaviorSubject<String>();
 final confirmpassword = BehaviorSubject<String>();
 final getBarangayId = BehaviorSubject<String>();
 



 
 Stream<String> get email => emailControlDicky.stream.transform(validateEmail);
 Stream<String> get name => nameControlDicky.stream.transform(validTextinput);
 Stream<String> get password => passwordControlDicky.stream.transform(validatePassword);
 Stream<String> get confirmpasswords => confirmpassword.stream.transform(validateConPassword)
 .doOnData((String event) {
   if(0 != passwordControlDicky.value.compareTo(event)){
     confirmpassword.addError('Password Not Match');
   }
  });
  
 Stream<String> get barangayId => getBarangayId.stream;
 Stream<String> get xcontactNumber => contactNumberControlDicky.stream.transform(validatePhoneNumberuser);
 Stream<bool> get submiited => Rx.combineLatest6(
   email, name, password, xcontactNumber, confirmpasswords, barangayId,(a, b, c, d,e,f) => true);
 

 Function(String) get changeEmail => emailControlDicky.sink.add;
 Function(String) get changeName =>  nameControlDicky.sink.add;
 Function(String) get changePassword => passwordControlDicky.sink.add;
 Function(String) get changeConfirmPassword => confirmpassword.sink.add;
 Function(String) get changebarangayId => getBarangayId.sink.add;
 Function(String) get changeContactNumber =>  contactNumberControlDicky.sink.add;

  testUser(String strinMesage ,BuildContext context) async{
    final validEmails = emailControlDicky.value ;
    final validName = nameControlDicky.value ;
    final validContactNumber = contactNumberControlDicky.value ;
    final validPassword =   passwordControlDicky.value;
    final valiConfirm = confirmpassword.value;
    final valiBarangayId = getBarangayId.value;
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)=> LoginPage()));
    print(" All Data $strinMesage $valiBarangayId $validEmails $validName $validContactNumber $validPassword $valiConfirm");
    

    
  }


  signUpUser(
    String file,
    double lat,double lng,
    BuildContext context,
    ) async{

    final validEmails = emailControlDicky.value ;
    final validName = nameControlDicky.value ;
    final validContactNumber = contactNumberControlDicky.value ;
    final validPassword =   passwordControlDicky.value;
    final validIdBararang =  getBarangayId.value;
    final validImagePath =  file ;

    if(validEmails != "" && validName != "" && validContactNumber != "" &&
      validPassword != "" && validIdBararang != "" 
      && validImagePath != "" 
      ){

         var data = {
          'name': validName ,
          'email': validEmails,
          'contactNumber': validContactNumber,
          'latitude': lat,
          'longitude': lng,
          'password': validPassword,
          'barangayId': validIdBararang,
          'imagePath': validImagePath
    };
    print(data);
    var response = await ApiCall().postData(data, '/register');
    var body = json.decode(response.body);
    if(response.statusCode == 200){
       if(body['success'] == true){
          UserGetPref().setuserJson(json.encode(body['user']));
           authShared.saveDataAccount(
          body['token'],
          body['user']['userType'].toString(),
          body['user']['latitude'].toString(),
          body['user']['longitude'].toString());
      authShared.userTypeScreen(context,
        body['user']['userType']);
         await ApiCall().getUserVerification('/submitVerification/${body['user']['id']}');
   
      }else{
         showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Contact Number or Email may be Already Existed",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }
    }else{
         showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Contact Number or Email may be Already Existed",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }
     
      

    }else{
         showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Please Look Again.",
        message: "Some may be Empty Fields",
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


  dispose(){
    emailControlDicky?.close();
    nameControlDicky?.close();
    passwordControlDicky?.close();
    contactNumberControlDicky?.close();
    confirmpassword?.close();
    getBarangayId?.close();
  }


}

final signUpBlocDicks = SignUpBlocDick();
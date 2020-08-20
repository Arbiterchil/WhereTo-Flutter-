import 'package:WhereTo/Admin/User_Verification/user_getterres.dart';
import 'package:WhereTo/Admin/User_Verification/user_verifyclass.dart';
import 'package:WhereTo/api/api.dart';
import 'dart:convert';
class UserApi{

Future<UserVerified> getUserUnVerified() async {

  try{

    var reponse = await ApiCall().getunverified('/getUnverifiedList');
    var body = json.decode(reponse.body);
    List<Unverified> unverified = [];
    for(var body in body){

        Unverified unverifiedUser = Unverified(

        userId: body["userId"],
        name: body["name"],
        imagePath: body["imagePath"],

        );

        unverified.add(unverifiedUser);
    }

    return UserVerified.fromJson(unverified);

  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
          return UserVerified.withError("$error");
  }

}

}
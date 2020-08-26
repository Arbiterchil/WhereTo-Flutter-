import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_responseRem.dart';
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
  Future<RemitResponse> getRemitImages() async {
    try{
      var response = await ApiCall().getRemitImage('/viewRiderRemittance');
      var bodies = json.decode(response.body);
      List<ViewRemit> viewRet = [];
      for(var bodies in bodies){
        ViewRemit vr = ViewRemit(
        id: bodies["id"],
        riderId: bodies["riderId"],
        amount: bodies["amount"],
        imagePath: bodies["imagePath"],
        status: bodies["status"],
        createdAt: DateTime.parse(bodies["created_at"]),
        updatedAt: DateTime.parse(bodies["updated_at"]),
        );
        viewRet.add(vr);
      }
      return RemitResponse.fromJson(viewRet);
    }catch(stacktrace,error){
  print("Error Occurence. $error and $stacktrace" );
      return RemitResponse.withError("$error");
    }
  }

}
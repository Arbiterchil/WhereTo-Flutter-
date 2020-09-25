import 'package:WhereTo/Admin/User_Verification/user_verifyclass.dart';

class UserVerified {



  final List<Unverified> userView;
  final String error;

  UserVerified(this.userView, this.error);

 UserVerified.fromJson(List<dynamic> json)
  : userView = 
  json.cast<Map<String,dynamic>>().map((e) => new Unverified.fromJson(e)).toList(),error = "" ;
    

  UserVerified.withError(String errorvalue)
  : userView = List(),
  error = errorvalue; 



}
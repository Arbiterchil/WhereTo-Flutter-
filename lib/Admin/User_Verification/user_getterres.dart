import 'package:WhereTo/Admin/User_Verification/user_verifyclass.dart';

class UserVerified {



  final List<Unverified> userView;
  final String error;

  UserVerified(this.userView, this.error);

 UserVerified.fromJson(List<dynamic> json)
  : userView = json,error = "" ;
    

  UserVerified.withError(String errorvalue)
  : userView = List(),
  error = errorvalue; 



}
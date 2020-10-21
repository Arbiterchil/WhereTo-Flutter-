

import 'package:WhereTo/A_loadingSimpe/riderLocationCity.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddCityRider{

  String cityRider = UserGetPref().riderSaveCitys; 
 
  plumming(BuildContext context){
    
    if(cityRider == null){
        
        showDialog(context: context,
      barrierDismissible: false,
      builder: (_)=>LocationRiderCity()
      );
    }else{
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => RiderProfile()));
      print("Nothing to do is Sleep");
    }
  }

}

final addCityRider = AddCityRider();
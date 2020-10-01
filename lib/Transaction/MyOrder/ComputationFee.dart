


import 'dart:convert';

import 'package:WhereTo/Transaction/Barangay/Barangay.class.dart';
import 'package:WhereTo/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComputationFee{
  Future<double> getFee(String barangayWidget, String barangayUser) async {
    double restoCharge = 0;
    double userCharge = 0;
    double totalOrder = 0;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    final barangay = await ApiCall().getData('/getBarangayList');
    List<BarangayList> barangayResponse = barangayListFromJson(barangay.body);
    String barangayname;
    var istrue = false;
    for (int z = 0; z < barangayResponse.length; z++) {
      if (barangayResponse[z].id.toString().contains(user['barangayId'].toString())) {
        barangayname = barangayUser;
        istrue = true;
        break;
      }
      
    }
    if (istrue) {
      if (barangayWidget.isNotEmpty) {
        if (barangayWidget.contains("Magugpo")) {
            restoCharge = 40;
        } else if (barangayWidget.contains("Apokon")) {
            restoCharge = 15;
        } else if (barangayWidget.contains("Bingcungan")) {
         
            restoCharge = 20;
        
        } else if (barangayWidget.contains("Busaon")) {
       
            restoCharge = 50;
       
        } else if (barangayWidget.contains("Canocotan")) {
         
            restoCharge = 15;
       
        } else if (barangayWidget.contains("La Filipina")) {
        
            restoCharge = 10;
        
        } else if (barangayWidget.contains("Liboganon")) {
         
            restoCharge = 50;
      
        } else if (barangayWidget.contains("Madaum")) {
         
            restoCharge = 30;
         
        } else if (barangayWidget.contains("Magdum")) {
         
            restoCharge = 10;
         
        } else if (barangayWidget.contains("Mankilam")) {
          
            restoCharge = 15;
         
        } else if (barangayWidget.contains("New Balamban")) {
          
            restoCharge = 30;
         
        } else if (barangayWidget.contains("Nueva Fuerza")) {
          
            restoCharge = 40;
         
        } else if (barangayWidget.contains("Pagsabangan")) {
          
            restoCharge = 25;
        
        } else if (barangayWidget.contains("Pandapan")) {
         
            restoCharge = 45;
         
        } else if (barangayWidget.contains("San Agustin")) {
         
            restoCharge = 45;
         
        } else if (barangayWidget.contains("San Isidro")) {
          
            restoCharge = 20;
       
        } else if (barangayWidget.contains("San Miguel")) {
          
            restoCharge = 15;
         
        } else if (barangayWidget.contains("Visayan")) {
          
            restoCharge = 20;
          
        }
      }
      if (barangayname.isNotEmpty) {
        if (barangayname.contains("Magugpo")) {
         
            userCharge = 40;
         
        } else if (barangayname.contains("Apokon")) {
          
            userCharge = 15;
          
        } else if (barangayname.contains("Bincungan")) {
        
            userCharge = 20;
         
        } else if (barangayname.contains("Busaon")) {
         
            userCharge = 50;
         
        } else if (barangayname.contains("Canocotan")) {
         
            userCharge = 15;
         
        } else if (barangayname.contains("La Filipina")) {
        
            userCharge = 10;
         
        } else if (barangayname.contains("Liboganon")) {
          
            userCharge = 50;
        
        } else if (barangayname.contains("Madaum")) {
         
            userCharge = 30;
       
        } else if (barangayname.contains("Magdum")) {
         
            userCharge = 10;
       
        } else if (barangayname.contains("Mankilam")) {
         
            userCharge = 15;
        
        } else if (barangayname.contains("New Balamban")) {
        
            userCharge = 30;
        
        } else if (barangayname.contains("Nueva Fuerza")) {
        
            userCharge = 40;
         
        } else if (barangayname.contains("Pagsabangan")) {
         
            userCharge = 25;
         
        } else if (barangayname.contains("Pandapan")) {
         
            userCharge = 45;
         
        } else if (barangayname.contains("San Agustin")) {
         
            userCharge = 45;
        
        } else if (barangayname.contains("San Isidro")) {
         
            userCharge = 20;
        
        } else if (barangayname.contains("San Miguel")) {
         
            userCharge = 15;
         
        } else if (barangayname.contains("Visayan Village")) {
         
            userCharge = 20;
         
        }
      }
    }
    if (barangayWidget.contains("Magugpo") &&
        barangayname.contains("Magugpo")) {
        totalOrder = 30;
    } else if (barangayWidget.contains("Magugpo") &&barangayname != "Magugpo" || barangayWidget!="Magugpo" &&barangayname.contains("Magugpo")) {
        totalOrder = restoCharge + userCharge;
    } else if (barangayWidget != "Magugpo" && barangayname != "Magugpo") {
        totalOrder = 30 + restoCharge + userCharge; 
    }else if(barangayWidget.contains(barangayname)){
        totalOrder =30;
    }
    return totalOrder;
    
  }
}

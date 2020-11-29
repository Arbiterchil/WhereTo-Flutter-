


import 'package:WhereTo/Transaction/Barangay/Barangay.class.dart';
import 'package:WhereTo/api/api.dart';
class ComputationFee{
  Future<double> getFee(String barangayWidget, String barangayID) async {
    double restoCharge = 0;
    double userCharge = 0;
    double totalOrder = 0;
    final barangay = await ApiCall().getData('/getBarangayList');
    List<BarangayList> barangayResponse = barangayListFromJson(barangay.body);
    String barangayname;
    var istrue = false;
    for (int z = 0; z < barangayResponse.length; z++) {
      if (barangayResponse[z].id.toString().contains(barangayID)) {
        barangayname = barangayResponse[z].barangayName;
        istrue = true;
        break;
      }
      
    }
   
    if (istrue) {
      if (barangayWidget.isNotEmpty) { 
        if (barangayWidget.contains("Magugpo")) {
            restoCharge = 30;
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
          
        }else if(barangayWidget.contains("Maco")) {

            restoCharge = 100;
        }else if(barangayWidget.contains("Asuncion")) {

            restoCharge = 100;
        }else if(barangayWidget.contains("Dujali")) {

            restoCharge = 100;
        }else if(barangayWidget.contains("Sto. Tomas")) {

            restoCharge = 180;
        }else if(barangayWidget.contains("Kapalong")) {

            restoCharge = 180;

        }else if(barangayWidget.contains("New Corella")) {

            restoCharge = 150;
        }else if(barangayWidget.contains("Mawab")) {

            restoCharge = 150;
        }else if(barangayWidget.contains("Mabini")) {

            restoCharge = 150;
        }
      }
      if (barangayname.isNotEmpty) {
        if (barangayname.contains("Magugpo")) {
         
            userCharge = 30;
         
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
         
        }else if (barangayname.contains("Maco")) {
         
            userCharge = 100;
         
        }else if (barangayname.contains("Asuncion")) {
         
            userCharge = 100;
         
        }else if (barangayname.contains("Dujali")) {
         
            userCharge = 100;
         
        }else if (barangayname.contains("Sto. Tomas")) {
         
            userCharge = 180;
         
        }else if (barangayname.contains("Kapalong")) {
         
            userCharge = 180;
         
        }else if (barangayname.contains("New Corella")) {
         
            userCharge = 150;
         
        }else if (barangayname.contains("Mawab")) {
         
            userCharge = 150;
         
        }else if (barangayname.contains("Mabini")) {
         
            userCharge = 150;
         
        }
      }
    }
    if (barangayWidget.contains("Magugpo") &&
        barangayname.contains("Magugpo")) {
        totalOrder = 30;
    } else if (barangayWidget.contains("Magugpo") &&barangayname != "Magugpo" || barangayWidget!="Magugpo" &&barangayname.contains("Magugpo")) {
        totalOrder = restoCharge + userCharge;
    } else if (barangayWidget.contains(barangayname)) {
      totalOrder =30; 
    }else if(barangayWidget != "Magugpo" && barangayname != "Magugpo"){
       totalOrder = 30 + restoCharge + userCharge; 
    }
    print(barangayname);
    return totalOrder;
    
  }
}


import 'package:onesignal_flutter/onesignal_flutter.dart';

class GetSignal {

Future<void> intSignalPaltForm() async{
String data ="";
 await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});  
  
    await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});  
     OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification){

        // setState(() {
           data = notification.payload.additionalData["force"].toString();
           print("$data is you");
          // if(data != null){
            if(data == "penalty"){
              //  _showDone(meesages.toString());
            }else{
              print("None");
            }
          // }
        // });
        
    });       

        
}


}

final getSignal = GetSignal();
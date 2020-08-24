import 'dart:async';

import 'package:WhereTo/Services/connectivity_status.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService{
  StreamController<ConnectivityStatus> controller =StreamController<ConnectivityStatus>();
  ConnectivityService(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var con =getStatus(result);
      controller.add(con);
     });
  }

  ConnectivityStatus getStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.mobile:
      return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
      return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
      default:
      return ConnectivityStatus.Offline;
    }
  }
}
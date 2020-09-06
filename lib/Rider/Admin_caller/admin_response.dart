import 'package:WhereTo/Rider/Admin_caller/admin_device.dart';

class AdminResponseDevice {



  final List<AdminDevices> adminResponse;
  final String error;

  AdminResponseDevice(this.adminResponse, this.error);

 AdminResponseDevice.fromJson(List<dynamic> json)
  : adminResponse = json,error = "" ;
    

  AdminResponseDevice.withError(String errorvalue)
  : adminResponse = List(),
  error = errorvalue; 



}
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class RiderRoute{

  getRoute(String destination)async{
  Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String url ="https://www.google.com/maps/dir/?api=1&origin=" + "${postion.latitude},${postion.longitude}" + "&destination=" + destination + "&travelmode=driving&dir_action=navigate";
  if(await canLaunch(url)){
    await launch(url);
  }else{
    return;
  }
  }
}
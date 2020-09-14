
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class GeolocatorService{
Location location =Location();
PublishSubject<LatLng> publishLatLng =PublishSubject();
Stream<LatLng> get sinkLatLng =>publishLatLng.stream;


   Future<void>getlatLng()async{
   location.onLocationChanged.listen((event) {
   publishLatLng.sink.add(LatLng(event.latitude,event.longitude));
   });
   
 }
 

 dispose()=>publishLatLng.close();
}
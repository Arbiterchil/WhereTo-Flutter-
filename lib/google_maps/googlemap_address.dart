import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapAdress extends StatefulWidget {
  @override
  _MapAdressState createState() => _MapAdressState();
}

class _MapAdressState extends State<MapAdress> {
  LatLng latlng =LatLng(8.0, 125.0);
  Completer<GoogleMapController> _controller =Completer();
  final Set<Marker> marker ={};
 @override
  void initState() {
    getLang();
    super.initState();
  }

  getLang() async{
  Position postion =await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  final coordinates =new Coordinates(postion.latitude,postion.longitude);
  LatLng _latlang =LatLng(coordinates.latitude, coordinates.longitude);
  setState(() {
    if(_latlang!=null){
      latlng =_latlang;
    }
  });
  }


  onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  onCameraPosition(CameraPosition position){
    latlng =position.target;
  }
 onMarkers(){
   
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: latlng==null ?LatLng(0,0) :latlng, 
              zoom: 18
              ),
              mapType: MapType.normal,
              markers: marker,
              onCameraMove: onCameraPosition,
              myLocationEnabled: true,              
              myLocationButtonEnabled: true,

            ),
        ],
      ),
    );
  }
}
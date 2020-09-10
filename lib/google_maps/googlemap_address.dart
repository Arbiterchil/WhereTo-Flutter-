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
  LatLng latlng;
  Completer<GoogleMapController> _controller =Completer();
  List<Marker> marker =[];
 @override
  void initState() {
    super.initState();
  }

  
  getPosition() async{
  Position postion =await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  LatLng coordinates =new LatLng(postion.latitude,postion.longitude);
  return coordinates;
  }


  onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: getPosition(),
            builder: (context,snapshot){
            if(snapshot.hasData){
              if(snapshot!=null){
                marker.add(Marker(
                  markerId: MarkerId('marker'),
                  draggable: false,
                  position: snapshot.data,
                ));
                return GoogleMap(
                zoomControlsEnabled: true,
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: snapshot.data, 
                  zoom: 17
                  ),
                  mapType: MapType.normal,
                  markers: Set.from(marker),            
                  myLocationButtonEnabled: true,
                  
                );
              }else{
                return Container();
              }
            }else{
              return Container();
            }
            }
            )
        ],
      ),
    );
  }
}
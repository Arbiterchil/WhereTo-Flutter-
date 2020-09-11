import 'dart:async';

import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_place/google_place.dart';

class MapAdress extends StatefulWidget {
  @override
  _MapAdressState createState() => _MapAdressState();
}

class _MapAdressState extends State<MapAdress> {
  LatLng latlng;
  GoogleMapController _controller;
  List<Marker> marker = [];
  String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
  TextEditingController search = new TextEditingController(text: "");
  List<AutocompleteResponse> predictions = [];
  PickResult selectedPlace;
  @override
  void initState() {
    
    super.initState();
  }

  getPosition() async {
    Position postion =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng coordinates = new LatLng(postion.latitude, postion.longitude);
    setState(() {
      latlng = coordinates;
   
      
    });
    return coordinates;
  }

  onMapCreated(GoogleMapController controller) {
    _controller = _controller;
  }

  onMove(AsyncSnapshot<dynamic> snapshot) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: snapshot.data, zoom: 17.0)));
  }

  //  _handlePress(String val) async {
  //   var googlePlace =GooglePlace(googleKey);
  //   var result = await googlePlace.autocomplete.get(val);
  //   if(result !=null && mounted){
  //     setState(() {
  //       // predictions =result.predictions[0].description;
  //       print(result.predictions[0].description);
  //     });
  //   }
  //   // Geolocator().placemarkFromAddress(val).then((value){
  //   //   _controller.animateCamera(CameraUpdate.newCameraPosition(
  //   //     CameraPosition(
  //   //       target: LatLng(value[0].position.latitude, value[0].position.longitude),
  //   //       zoom: 10,
  //   //       )
  //   //   ));
  //   // });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: getPosition(),
            builder: (context, snapshot) {
              // if (snapshot.hasData) {
              //   if (snapshot != null) {
              //     marker.add(Marker(
              //       markerId: MarkerId('marker'),
              //       draggable: false,
              //       position: snapshot.data,
              //     ));
              //     return GoogleMap(
              //       zoomControlsEnabled: true,
              //       onMapCreated: onMapCreated,
              //       initialCameraPosition: CameraPosition(
              //         target: snapshot.data,
              //         zoom: 17,
              //         bearing: 45.0,
              //       ),
              //       mapType: MapType.normal,
              //       markers: Set.from(marker),
              //       myLocationButtonEnabled: true,
              //       myLocationEnabled: true,
              //     );
              //   } else {
              //     return Container();
              //   }
              // } else {
              //   return Center(
              //     child: CircularProgressIndicator(strokeWidth: 4.5,
              //     ),
              //   );
              // }
              return PlacePicker(
              apiKey: googleKey,
              initialPosition: snapshot.data,
              useCurrentLocation: true,
              searchForInitialValue: true,
              
              usePlaceDetailSearch: true,
              onPlacePicked: (result) {
              selectedPlace = result;
              
              Navigator.pop(context);
            },
          );
          
            })
          
        ],
      ),
    );
  }
}

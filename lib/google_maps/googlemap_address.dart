import 'dart:async';
import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Map<dynamic, dynamic> address;
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
                  onPlacePicked: (result) async {
                    ProgressDialog map= ProgressDialog(context);
                    map.style(
                        message: "Getting Location",
                        borderRadius: 10.0,
                        backgroundColor: Colors.white,
                        progressWidget: CircularProgressIndicator(),
                        elevation: 10.0,
                        insetAnimCurve: Curves.easeInExpo,
                        progressTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Gilroy-light"));
                    map = ProgressDialog(context, type: ProgressDialogType.Normal,
                    isDismissible: false);
                    map.show();
                    selectedPlace = result;
                    var id = await ID().getId();
                    if (selectedPlace != null) {
                      address = {
                        "userId": "$id",
                        "addressName": "${result.formattedAddress.toString()}",
                        "latitude":
                            "${result.geometry.location.lat.toString()}",
                        "longitude":
                            "${result.geometry.location.lng.toString()}",
                      };
                      var res = await ApiCall().newAddress(address, '/assignNewAddress');
                      if (res.statusCode == 200) {
                        Navigator.pop(context);
                        map.hide();
                      }
                    }
                  },
                );
              })
        ],
      ),
    );
  }
}

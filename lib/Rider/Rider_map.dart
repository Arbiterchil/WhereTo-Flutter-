import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class RiderLocationMap extends StatefulWidget {
  
  final  String addressLocation;

  const RiderLocationMap({Key key, this.addressLocation}) : super(key: key);

  @override
  _RiderLocationMapState createState() => _RiderLocationMapState(addressLocation);
}

class _RiderLocationMapState extends State<RiderLocationMap> {
final  String addressLocation;
  

  _RiderLocationMapState(this.addressLocation);
  LatLng latlng = new LatLng(12.8797,121.7740);
String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
var latitude;
var longtitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: WillPopScope(
            onWillPop: () async => true,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    mapGo(),
                  ],
                ),
              )),
          ),
    );
  }

  Widget mapGo(){
    return Container(
      height: 700,
      width: MediaQuery.of(context).size.width,
      child: PlacePicker(
                    apiKey: googleKey,
                    initialPosition: latlng,
                    useCurrentLocation: true,
                    searchForInitialValue: true,
                    usePlaceDetailSearch: true,
                    onPlacePicked: (result) async {
                      String lat = result.geometry.location.lat.toString();
                      String lng = result.geometry.location.lng.toString();
                      print("the Bilat is $lat and Oten is $lng");
                      latitude = lat;
                      longtitude = lng;
                      }
                  ),
    );
  }

}
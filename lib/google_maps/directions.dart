import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/google_maps/stream_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Directions extends StatefulWidget {
  @override
  _DirectionsState createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  GoogleMapController _controller;
  List<Marker> marker = [];
  Location location = new Location();
  final id = GeolocatorService();
  String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
  final Set<Polyline> polyline ={};
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk");
  getpoints() async{
    location.onLocationChanged.listen((event) async{
    routeCoords =await googleMapPolyline.getCoordinatesWithLocation(
      origin:LatLng(event.latitude, event.longitude) , 
      destination: LatLng(7.447920,125.804894), 
      mode: RouteMode.walking
      );
      polyline.add(Polyline(
      polylineId: PolylineId("route1"),
      visible: true,
      points: routeCoords,
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.buttCap
      ));
     
     
      print("${event.latitude},${event.longitude}");
    });
  }
  onMapCreated(GoogleMapController controller) {
    _controller = _controller;
  }

  onMove(GoogleMapController controller) async{
    var route =await ID().getCoordinatesFormat();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: route, zoom: 17.0)));
  }
  onGetLocation(){
    id.getlatLng();
  }
 
  @override
  void initState() {
    super.initState();
    // getpoints();
    
  }
  @override
  void dispose() {
    super.dispose();
    getpoints();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      onGetLocation();
    });
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: IconButton(
                icon: Icon(Icons.location_on), onPressed: () async {
                  setState(() {
                  getpoints();
                  });
                })),
        body: StreamBuilder(
            stream: id.publishLatLng,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot != null) {
                  marker.add(Marker(
                    markerId: MarkerId('marker'),
                    draggable: false,
                    position: snapshot.data,
                  ));
                   
                  return GoogleMap(
                    polylines:/* Set<Polyline>.of(polylines.values)*/polyline,
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: snapshot.data,
                      zoom: 17,
                      bearing: 45.0,
                    ),
                    mapType: MapType.normal,
                    markers: Set.from(marker),
                  );
                } else {
                  return Container();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.5,
                  ),
                );
              }
            }));
  }
}

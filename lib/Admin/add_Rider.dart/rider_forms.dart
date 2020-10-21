

import 'package:WhereTo/A1_NewSingleBottomNav/Single_customfield/single.customField.dart';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/add_Rider.dart/riderbloc.dart';
import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'dart:ui';
import '../../styletext.dart';

class RiderForms extends StatefulWidget {
  @override
  _RiderFormsState createState() => _RiderFormsState();
}

class _RiderFormsState extends State<RiderForms> {
    LatLng latlng = new LatLng(12.8797,121.7740);
String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
    final formkey = GlobalKey<FormState>();
    String selectPerson;
   bool loading = false;
   double lats;
   double longs ;
   double toShowAddress;


  FocusNode fullname;
  FocusNode email;
  FocusNode contacts;
  FocusNode license;
  FocusNode palte;
 


  @override
  void initState() {
    super.initState();
    bararangStream..getBarangayListFormDb();
     fullname = FocusNode();
   email = FocusNode();
   contacts = FocusNode();
   license = FocusNode();
   palte = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    bararangStream..drainStreamData();
  }


  Widget fullRN(RiderBloc riderBloc){
     return CustomTextFieldFixStyle(
      stream: riderBloc.fr,
      obsecure: false,
      onchangeTxt: riderBloc.cfr,
      iconText: EvaIcons.person,
      type: TextInputType.name,
      hintTxt: "Full Name",
      labelText: "Full Name",
      nodes: fullname ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(email),
    );
  }
  Widget emailRn(RiderBloc riderBloc){
    return CustomTextFieldFixStyle(
      stream: riderBloc.em,
      obsecure: false,
      onchangeTxt: riderBloc.cem,
      iconText: EvaIcons.email,
      type: TextInputType.emailAddress,
      hintTxt: "whereto@example.com",
      labelText: "Email",
      nodes: email,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(contacts),
    );
  }
   Widget phone(RiderBloc riderBloc){
    return CustomTextFieldFixStyle(
      stream: riderBloc.cr,
      obsecure: false,
      onchangeTxt: riderBloc.ccr,
      iconText: EvaIcons.phone,
      type: TextInputType.number,
      hintTxt: "09XXXXXXXXX",
      labelText: "Contact Number",
      nodes: contacts ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(license),
    );
  }
  Widget licenRn(RiderBloc riderBloc){
     return CustomTextFieldFixStyle(
      stream: riderBloc.lr,
      obsecure: false,
      onchangeTxt: riderBloc.clr,
      iconText: EvaIcons.creditCard,
      type: TextInputType.name,
      hintTxt: "License",
      labelText: "License",
      nodes: license,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(palte),
    );
  }

  Widget plateRn(RiderBloc riderBloc){
     return CustomTextFieldFixStyle(
      stream: riderBloc.pr,
      obsecure: false,
      onchangeTxt: riderBloc.cpr,
      iconText: EvaIcons.colorPalette,
      type: TextInputType.name,
      hintTxt: "Plate Number",
      labelText: "Plate Number",
      nodes: palte,
      actions: TextInputAction.done,
      submit: (_)=>FocusScope.of(context).requestFocus(FocusNode()),
    );
  }
   Widget barangay(){   
    return StreamBuilder<BaranggayRespone>(
      stream: bararangStream.subject.stream,
      builder: (context,AsyncSnapshot<BaranggayRespone> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _view(snaphot.data,riderBloc);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }

  Widget formSub(RiderBloc riderBloc){
     return StreamBuilder(
      stream: riderBloc.subs,
      builder: (context, snaps) 
      => Container(
        height: 50,
        width: 150,
        child: RaisedButton(
          color: pureblue,
          splashColor: wheretoDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60)
          ),
          child:Center(
                            child: Text("Add Rider",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy-light'
                            ),
                            ), 
                        ),
          onPressed: snaps.hasData
          ?() => navigatepage(riderBloc):null),
      ));
  }

  void navigatepage(RiderBloc riderBloc) async{

    if(lats == null && longs == null){
      showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Please Select The Restaurant Address.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else{
      setState(() {
        loading = true;
      });
      await riderBloc.signUpRider(lats, longs, context);
      setState(() {
        loading = false;
      });

    }

  }

  Widget spinKitDots(){
  return Container(
    height: 40,
    width: 60,
    child: SpinKitThreeBounce(
      color: pureblue,
      size: 30,
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  fullRN(riderBloc),
                  SizedBox(height: 12,),
                  emailRn(riderBloc),
                  SizedBox(height: 12,),
                  phone(riderBloc),
                  SizedBox(height: 12,),
                  licenRn(riderBloc),
                  SizedBox(height: 12,),
                  plateRn(riderBloc),
                  SizedBox(height: 12,),
                  barangay(),
                  SizedBox(height: 12,),
                  FutureBuilder(
                  future: CoordinatesConverter().getAddressByLocation(
                    lats.toString()+","+longs.toString(),),
                  builder: (con ,snaps){
                    if(snaps.data == null){
                     return  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: "Rider Address or Place",
                    onTap: () => viewMapo(),
                  );
                    }else{
                       return  
                  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: snaps.data,
                    onTap: () => viewMapo(),
                  );
                    }
                  },
                ),
                  SizedBox(height: 22,),
                  loading ? spinKitDots():
                  formSub(riderBloc),
                ],
              ),
            ),
          ),
        ),
        );

   
          
   
  }

   Widget _view(BaranggayRespone respone,RiderBloc ric){
     List<Barangays> bararangs = respone.bararangSaika;
    if(bararangs.length == 0 ){
          return Container(
            child: Text('Come Back Later.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{ 
             return Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ),
              ),
              child: Padding(
               padding: const EdgeInsets.only(left: 10),
               child: DropdownButtonHideUnderline(
                 child: Stack(
                   children: [
                     Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Icon(
                                Icons.place,
                                color: Color(0xFF0F75BB),
                              ),
                            )),
                    Padding(
                       padding: const EdgeInsets.only(left: 30),
                       child: ButtonTheme(
                         alignedDropdown: true,
                         child: StreamBuilder(
                           stream: ric.br,
                           builder: (context, snaps){
                             return   DropdownButton<String>(
                             isExpanded: true,
                             hint:  Text(
                                    "Select Barangay",
                                    style: TextStyle(
                                        color: Color(0xFF0F75BB),
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                   dropdownColor: Colors.white,
                                   icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:Color(0xFF0F75BB),
                                  ),
                                
                             items: bararangs.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.barangayName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value:snaps.data,
                               
                             onChanged: (val){
                               ric.cbr(val);
                             },
                             );
                           },
                          
                         ),
                       ),
                      ),        
                   ],
                 ),
               ),
                ),
                );
        }
  }  

  Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
 Widget _loading(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }


 void viewMapo(){

  showModalBottomSheet(
    isDismissible: true,
    context: context, 
  builder: (_){

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
        height: 390,
        width: MediaQuery.of(context).size.width,
        child: PlacePicker(
                      apiKey: googleKey,
                      initialPosition: latlng,
                      useCurrentLocation: true,
                      searchForInitialValue: true,
                      usePlaceDetailSearch: true,
                      onPlacePicked: (result) async {
                        double lat = result.geometry.location.lat;
                        double lng = result.geometry.location.lng;
                        print("the Bilat is $lat and Oten is $lng");
                        setState(() {
                        lats = lat;
                        longs = lng;
                        });
                        Navigator.pop(context);
                        }
                    ),
      ),
        ],
      ),
    );

  });
  
} 
}

class NCard extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  const NCard({this.active,this.icon,this.onTap,this.label});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 55.0,
        width: MediaQuery.of(context).size.width,
         decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ,),),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(icon,color: pureblue,size: 15.0,),
              SizedBox(width: 7.0,),

               Flexible(
                 flex: 1,
                 child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Text(label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: pureblue,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'
                        ),),
                      ),
                    ),
               ),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
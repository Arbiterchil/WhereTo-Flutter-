import 'dart:convert';

import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../styletext.dart';

class RiderForms extends StatefulWidget {
  @override
  _RiderFormsState createState() => _RiderFormsState();
}

class _RiderFormsState extends State<RiderForms> {

    TextEditingController fullanme  = TextEditingController();
    TextEditingController addressmadafa = TextEditingController();
    TextEditingController contactnumber = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController licensenumber = TextEditingController();
    TextEditingController plateNumber = TextEditingController();
    LatLng latlng = new LatLng(12.8797,121.7740);
String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
    final formkey = GlobalKey<FormState>();
    String selectPerson;
   bool loading = false;
   double lats;
   double longs ;
   double toShowAddress;
  @override
  void initState() {
    super.initState();
    bararangStream..getBarangayListFormDb();
    // callBarangay();
  }

  // List<dynamic> dataBarangay = List();
  // void callBarangay() async{

  //   var respon = await ApiCall().getBararang('/getBarangayList');
  //   var bararang = json.decode(respon.body);
  
  //   setState(() {
  //     dataBarangay = bararang;
  //   });
  //   // print(bararang);
  // }
  phoneValidate(String val){
          Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
          RegExp regExp = new RegExp(pattern);
          if (val.length == 0 ){
            return 'Please enter your number';
          }else if (val.length < 11){
            return 'Mobile Number Consist of 11 Digits';
          }
          else if(!regExp.hasMatch(val)){
            return 'Enter A Valid Contact Number';
          }
          else{
            return null;
          }

    }     
  emailValidate(String value){
      Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
    }
  
  @override
  void dispose() {
    super.dispose();
    bararangStream..drainStreamData();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          // SizedBox(height: 10.0,),
          // Text('Full Name',
          //           style: eLabelStyle,
          //           ),
          SizedBox(height: 10.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: fullanme,
                validator: (val) => val.isEmpty ? ' Please Put Your Restaurant Name' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.shop,
                    color: pureblue,
                  ),
                  hintText: 'Full Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
          // Text('Email',
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: email,
                validator: (val)=> emailValidate(email.text = val),
                    onSaved: (val) => email.text = val,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: pureblue,
                  ),
                  hintText: 'Email',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          // Text('Address',
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          SizedBox(height: 15.0,),
          FutureBuilder(
                  future: CoordinatesConverter().getAddressByLocation(lats.toString()+","+longs.toString(),),
                  builder: (con ,snaps){
                    if(snaps.data == null){
                     return  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: "Ok No View.",
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
          // Container(
          //     width: MediaQuery.of(context).size.width,
          //     alignment: Alignment.centerLeft,
          //     decoration: eBoxDecorationStyle,
          //     height: 50.0,
          //     child: TextFormField(
          //       cursorColor: pureblue,
          //       controller: addressmadafa, 
          //       validator: (val) => val.isEmpty ? ' Please Put A Address Name' : null,
          //       style: TextStyle(
          //         color: pureblue,
          //         fontFamily: 'Gilroy-light',
          //       ),
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //         contentPadding: EdgeInsets.only(top:14.0),
          //         prefixIcon: Icon(
          //           Icons.my_location,
          //           color: pureblue,
          //         ),
          //         hintText: 'Address',
          //         hintStyle: eHintStyle,
          //       ),
          //     ),
          //   ),
          SizedBox(height: 15.0,),
          // Text('Contact Number',
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor:pureblue,
              keyboardType: TextInputType.number,
                controller: contactnumber,
                validator: (val)=> phoneValidate(contactnumber.text = val),
                onSaved: (val) => contactnumber.text = val,    
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: pureblue,
                  ),
                  hintText: '09**********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
          // Text("Barangay",
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          // Container(
          //     width: MediaQuery.of(context).size.width,
          //     alignment: Alignment.centerLeft,
          //     decoration: eBoxDecorationStyle,
          //     height: 50.0,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 10),
          //       child: DropdownButtonHideUnderline(
          //             child:
          //   Stack(
          //               children: <Widget>[
          //                 Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: Icon(Icons.place,color: pureblue)),
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 30),
          //                   child:
                            
                            
          //                    DropdownButton(
          //                         isExpanded: true ,
          //                         hint: Text( "Select Barangay",
          //                         style: TextStyle(
                                      
          //                             color: pureblue,
          //                             fontFamily: 'Gilroy-light'
          //                           ),),
          //                         dropdownColor:  Colors.white,
          //                         icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
          //                         value: selectPerson,
          //                         items: dataBarangay.map((item) {
          //                         return new DropdownMenuItem(
          //                           child: Text(item['barangayName'],
          //                           style: TextStyle(
                                      
          //                             color: pureblue,
          //                             fontFamily: 'Gilroy-light'
          //                           ),
          //                           ),
          //                           value: item['id'].toString(),
          //                         );
          //                       }).toList(),
          //                         onChanged: (item){
          //                           setState(() {
          //                             selectPerson = item;
          //                             print(item);
          //                           });
          //                         }
          //                         ),
          //                 ),
          //               ],
          //             ),
          //           ),
                  
          //     )
          //   ),
           StreamBuilder<BaranggayRespone>(
      stream: bararangStream.subject.stream,
      builder: (context,AsyncSnapshot<BaranggayRespone> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _view(snaphot.data);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      }),
          SizedBox(height: 15.0,),
          // Text('License Number',
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: licensenumber,
                validator: (val) => val.isEmpty ? ' Please Put A License Number' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: pureblue,
                  ),
                  hintText: 'License Number',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
          // Text('Plate Name',
          //           style: eLabelStyle,
          //           ),
          // SizedBox(height: 10.0,),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: plateNumber,
                validator: (val) => val.isEmpty ? ' Please Put A Plate Number' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.details,
                    color: pureblue,
                  ),
                  hintText: 'Plate Number',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
          SizedBox(height: 15.0,),
        //  Container(
        //         width: MediaQuery.of(context).size.width,
        //         padding: EdgeInsets.symmetric(vertical: 25.0),
        //         child: RaisedButton(
        //           onPressed: (){

        //          saveForm();
        //           },
        //           elevation: 5.0,
        //           padding: EdgeInsets.all(8.0),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(30.0),
        //           ),
        //           color: Colors.white,
        //           child: Text(  loading ? 'Loading....' : 'Register',
        //           style: TextStyle(
        //             color: Color(0xFF527DAA),
        //             letterSpacing: 1.5,
        //             fontSize: 16.0,
        //             fontWeight: FontWeight.bold,
        //             fontFamily: 'Gilroy-light',
        //           ),),
        //           ),
        //       ),  
        Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                      Align(
                        alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: 
                            // (){
                            //   Navigator.pushReplacement(  
                            // context,
                            // new MaterialPageRoute(
                            //     builder: (context) => AddmenuAdmin()));
                            // },
                            saveForm,
                            child: Container(
                              height: 50,
                              width: 110,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text( loading ? '....' : 'Register <',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            
                          ),
                          ),
                      ),
                    ],
                  ),
                       ),
        ],
      ),
      
    );
  }

   Widget _view(BaranggayRespone respone){
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
                    width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
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
                              padding: const EdgeInsets.only(top:10.0),
                              child: Icon(
                                Icons.place,
                                color: Color(0xFF0F75BB),
                              ),
                            )),
                    Padding(
                       padding: const EdgeInsets.only(left: 30),
                       child: ButtonTheme(
                         alignedDropdown: true,
                         child: DropdownButton<String>(
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
                               value:selectPerson,
                               
                             onChanged: (val){
                               setState(()=>selectPerson = val);
                             },
                             )
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

  void saveForm() async {

    setState(() {
    loading = true;
  });


    if(selectPerson == null){

    _showDistictWarning("Select Barangay");
  }else{
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      var data = {
            "name" : fullanme.text,
            "email" : email.text,
            "contactNumber" : contactnumber.text,
            "latitude": lats.toString(),
            "longitude": longs.toString(),
            "barangayId": selectPerson.toString(),
            "licenseNumber": licensenumber.text,
            "plateNumber": plateNumber.text
    };

    await ApiCall().addRider(data, '/addRider');
    fullanme.clear();
    email.clear();
    address.clear();
    contactnumber.clear();
    licensenumber.clear();
    plateNumber.clear();
    _showDone();
    }

  }

    


    setState(() {
    loading = false;
  });
  }
  void _showDistictWarning(String message){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(message,
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      ),
    ); 
    },);
}
  void _showDone(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustomDOne(context),
    ); 
    },);
}
 mCustomDOne(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Rider is Registered.",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "OK", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
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
                          // 
                        lats = lat;
                        longs = lng;
                        });
                        // print(lats+"-"+longs);
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
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   color: Color(0xFF0C375B),
        //   borderRadius: BorderRadius.all(Radius.circular(40))
        // ),
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        decoration: eBoxDecorationStyle,
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
                          fontWeight: FontWeight.w700,
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
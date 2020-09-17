import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:WhereTo/Admin/admin_addmenu.dart';
import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../styletext.dart';

class AdminAddRestaurant extends StatefulWidget {
  @override
  _AdminAddRestaurantState createState() => _AdminAddRestaurantState();
}

class _AdminAddRestaurantState extends State<AdminAddRestaurant> {

    LatLng latlng = new LatLng(12.8797,121.7740);
String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";

    final scaffoldKey = new GlobalKey<ScaffoldState>();
    TextEditingController owner  = TextEditingController();
    TextEditingController respresent = TextEditingController(); 
    TextEditingController retaurantname  = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController contactnumber = TextEditingController();
    final formkey = GlobalKey<FormState>();
    String selectPerson;
    String opentimeString;
    String closetimeString;
    String datesofdays;
    String features;
    List<dynamic> dataBarangay = List();
    bool loading = false;
    final pick = ImagePicker();
   File _idPickerImage;
   String stringPath;
   var thimagelink; 
   double lats ;
   double longs;
   String toShowAddress = "";

    var nani;
    Map<String , String> weekDays = {};
    List<dynamic> weekAdd = [];
     List resultant = [];
     Map<String , int> shit = {};
    var nandato;
    Map<String,String> featu= {};
    List<dynamic> addfea = [];
    List finalres = [];
    Map<String,int> shithis ={};   

    List<String> featuring =
    [
      "Not Featured",
      "Featured"
    ];  

    void _featured(){
      for(int i=0; i < featuring.length;i++){
        nandato = i.toString();
        featu ={
          'namaeh': featuring[i],
          'id': nandato
        };
        addfea.add(featu);
      }
      for(int x= 0 ; x < addfea.length; x++){
        finalres.add(addfea[x]);
      }
      shithis.forEach((key, value) { 
        finalres.add(
          {
            'namaeh':value,
              'id': value
          }
        );
      });
    }

     List<String> weeks = 
    [
      "None",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thurday",
      "Friday",
      "Saturaday",
      "Sunday"
    ];
    void weekdays(){
          for(int i = 0 ; i < weeks.length ; i++){
            nani = i.toString();
            weekDays = {
              'dayname' : weeks[i],
              'id': nani
            };
            weekAdd.add(weekDays);

          }
      for(int x = 0; x < weekAdd.length; x++){
      resultant.add(weekAdd[x]);
     }

     shit.forEach((key ,val) { 
      resultant.add(
      {
      'dayname': val,
      'id': val
      });
      });
    }
    List<String> opentime = 
    [
      "1:00:00",
      "2:00:00",
      "3:00:00",
      "4:00:00",
      "5:00:00",
      "6:00:00",
      "7:00:00",
      "8:00:00",
      "9:00:00",
      "10:00:00",
      "11:00:00",
      "12:00:00",

    ];
    List<String> closetime = 
    [
      "13:00:00",
      "14:00:00",
      "15:00:00",
      "16:00:00",
      "17:00:00",
      "18:00:00",
      "19:00:00",
      "20:00:00",
      "21:00:00",
      "22:00:00",
      "23:00:00",
      "24:00:00",

    ];

  
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

    Widget formAdd(){
      return Form(
        key: formkey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
            children: <Widget>[
                SizedBox(height: 10.0,),

                Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: owner,
                validator: (val) => val.isEmpty ? ' Please Put The Owner\'s Name' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: pureblue,
                  ),
                  hintText: 'Owner\'s Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: respresent,
                validator: (val) => val.isEmpty ? ' Please Put The Representative Name' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: pureblue,
                  ),
                  hintText: 'Representative Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
              //  Text('Restaurant Name',
              //       style: eLabelStyle,
              //       ),
              //       SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: retaurantname,
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
                  hintText: 'Restaurant Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
                //  Text('Address',
                //     style: eLabelStyle,
                //     ),
                //     SizedBox(height: 10.0,),

                FutureBuilder(
                  future: CoordinatesConverter().convert(lats,longs),
                  builder: (con ,snaps){
                    if(snaps.data == null){
                     return  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: toShowAddress ,
                    
                    onTap: () => viewMapo(),
                  );
                    }else{
                       return  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: snaps.data ,
                    onTap: () => viewMapo(),
                  );
                    }
                  },
                ),
            //         Container(
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.centerLeft,
            //   decoration: eBoxDecorationStyle,
            //   height: 50.0,
            //   child: TextFormField(
            //     cursorColor: pureblue,
            //     onTap: () => viewMapo(),
            //     controller: address,
            //     validator: (val) => val.isEmpty ? ' Please Put Your Address' : null,
            //     style: TextStyle(
            //       color: pureblue,
            //       fontFamily: 'Gilroy-light',
            //     ),
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.only(top:14.0),
            //       prefixIcon: Icon(
            //         Icons.my_location,
            //         color: pureblue,
            //       ),
            //       hintText: 'Address',
            //       hintStyle: eHintStyle,
            //     ),
            //   ),
            // ),
             SizedBox(height: 15.0,),
                //  Text('Contact Number',
                //     style: eLabelStyle,
                //     ),
                //     SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
              keyboardType: TextInputType.number,
                controller: contactnumber,
                validator: (val)=> phoneValidate(contactNumber.text = val),
                    onSaved: (val) => contactNumber.text = val,
                    
                

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
            //         style: eLabelStyle,
            //         ),
            //         SizedBox(height: 10.0,),
            //         Container(
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.centerLeft,
            //   decoration: eBoxDecorationStyle,
            //   height: 50.0,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10),
            //     child: DropdownButtonHideUnderline(
            //           child:
            // Stack(
            //             children: <Widget>[
            //               Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: Icon(Icons.place,color: pureblue,)),
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 30),
            //                 child:
                            
                            
            //                  DropdownButton(
            //                       isExpanded: true ,
            //                       hint: Text( "Select Barangay",
            //                       style: TextStyle(
                                      
            //                           color:pureblue,
            //                           fontFamily: 'Gilroy-light'
            //                         ),),
            //                       dropdownColor: Colors.white,
            //                       icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
            //                       value: selectPerson,
            //                       items: dataBarangay.map((item) {
            //                       return new DropdownMenuItem(
            //                         child: Text(item['barangayName'],
            //                         style: TextStyle(
                                      
            //                           color: pureblue,
            //                           fontFamily: 'Gilroy-light'
            //                         ),
            //                         ),
            //                         value: item['id'].toString(),
            //                       );
            //                     }).toList(),
            //                       onChanged: (item){
            //                         setState(() {
            //                           selectPerson = item;
            //                           print(item);
            //                         });
            //                       }
            //                       ),
            //               ),
            //             ],
            //           ),
            //         ),
                  
            //   )
            // ),

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
            // Text("Open Time",
            //         style: eLabelStyle,
            //         ),
            //         SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.access_time,
                            color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Open Time",
                                  style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: opentimeString,
                                  items: opentime.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item,
                                    style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      opentimeString = item;
                                      print(item);
                                      
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),
             SizedBox(height: 15.0,),
            // Text("Close Time",
            //         style: eLabelStyle,
            //         ),
            //         SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.timer_off,
                            color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Close Time",
                                  style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: closetimeString,
                                  items: closetime.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item,
                                    style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item.toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      closetimeString = item;
                                      print(item);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),

             SizedBox(height: 15.0,),
            // Text("Close On",
            //         style: eLabelStyle,
            //         ),
            //         SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.weekend,
                            color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Close On Day",
                                  style: TextStyle(
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: datesofdays,
                                  items: resultant.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['dayname'],
                                    style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      datesofdays = item;
                                      print(item);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),
            
             SizedBox(height: 15.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.featured_play_list,
                            color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Featured or Not",
                                  style: TextStyle(
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: features,
                                  items: finalres.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['namaeh'],
                                    style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      features = item;
                                      print(item);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),

              // SizedBox(height: 10.0,),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.symmetric(vertical: 25.0),
              //   child: RaisedButton(
              //     onPressed: (){
              //       print(resultant);
              //     //   Navigator.pushReplacement(  
              //     // context,
              //     // new MaterialPageRoute(
              //     //     builder: (context) => AddmenuAdmin()));
              //     // addRestaurant();
              //     _addResturant();
              //     },
              //     elevation: 5.0,
              //     padding: EdgeInsets.all(8.0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     color: Colors.white,
              //     child: Text(  loading ? 'Loading....' : 'Register',
              //     style: TextStyle(
              //       color: Color(0xFF527DAA),
              //       letterSpacing: 1.5,
              //       fontSize: 16.0,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: 'Gilroy-light',
              //     ),),
              //     ),
              // ),
  

            ],
          ),
        ),
      );
    }

     getYourIdImage( ImageSource source) async{

    var imageIdValid = await pick.getImage(source: source); 
       File crop = await ImageCropper.cropImage(
      sourcePath: imageIdValid.path ,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Where To Id Cropper',
          toolbarColor: pureblue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ) );
    setState(() {
      _idPickerImage = crop;
      
      // print(imageIdValid.path);
    });
    

  }


   Widget _getImage(){

    if(_idPickerImage != null){

      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10),
          ),
          ),
          child: Image.file(
              _idPickerImage,
              fit: BoxFit.cover,
          ),
        ),
      );
    }else{
        return Container(
          width: 80,
        height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pureblue
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
    }

  }



  @override
  void initState() {
    
    super.initState();
    // callBarangay();
    weekdays();
    _featured();
    bararangStream..getBarangayListFormDb();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bararangStream..drainStreamData();
  }
//  void callBarangay() async{

//     var respon = await ApiCall().getBararang('/getBarangayList');
//     var bararang = json.decode(respon.body);
  
//     setState(() =>  dataBarangay = bararang);
//     // print(bararang);

//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 40,right: 40,top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     SizedBox(height: 10,),
                    _getImage(),
                    SizedBox(height: 20,),
                        GestureDetector(
                              onTap: (){
                                getYourIdImage(ImageSource.gallery);

                              }, 
                              child: Container(
                                height: 40,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: pureblue,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Center(
                                 child: Icon(Icons.picture_in_picture,
                                 size: 20,
                                 color: Colors.white
                                 ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                      formAdd(),
                      SizedBox(height: 40,),
                       Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                      Align(
                        alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: 
                            // () async{

                              

                            // //   Navigator.pushReplacement(  
                            // // context,
                            // // new MaterialPageRoute(
                            // //     builder: (context) => AddmenuAdmin()));
                            // },
                            _addResturant,
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
                        SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
            
        ),
        
        onWillPop: () async => false),
    );
  }

  void _addResturant() async{
setState(() {
     loading =true;
   });
    // if(_idPickerImage == null){
    //                             print("Please Select your valid id. ");
    //                          }else{

    //                            var viewthis = path.basename(_idPickerImage.path);
    //                         CloudinaryClient client = new CloudinaryClient(
    //                           "822285642732717",
    //                           "6k0dMMg3As30mPmjeWLeFL5-qQ4",
    //                           "amadpogi");
    //                         await client.uploadImage( _idPickerImage.path ,filename: "Restaurant/$viewthis") .then((result){
    //                             stringPath = result.secure_url;
    //                               print(stringPath);
    //                               thimagelink = stringPath;
    //                           })
    //                           .catchError((error) => print("ERROR_CLOUDINARY::  $error"));

    //                          }
    if(selectPerson == null || opentimeString == null ||
       closetimeString == null || datesofdays == null || toShowAddress.isEmpty){
         print('tan aw balik sa part');
         _showDial("Please Specify all empty Fields");
    }else if(_idPickerImage == null){
      _showDial("Please Select an Image.");
    }else{
       if(formkey.currentState.validate()){
          formkey.currentState.save();
          var viewthis = path.basename(_idPickerImage.path);
                            CloudinaryClient client = new CloudinaryClient(
                              "822285642732717",
                              "6k0dMMg3As30mPmjeWLeFL5-qQ4",
                              "amadpogi");
                            await client.uploadImage( _idPickerImage.path ,filename: "Restaurant/$viewthis") .then((result){
                                stringPath = result.secure_url;
                                  print(stringPath);
                                  thimagelink = stringPath;
                              })
                              .catchError((error) => print("ERROR_CLOUDINARY::  $error"));
        var data = {
                "restaurantName": retaurantname.text,
                "latitude": lats.toString(),
                "longitude": longs.toString(),
                "barangayId": selectPerson.toString(), 
                "contactNumber": contactnumber.text,
                "openTime": opentimeString.toString(), 
                "closingTime": closetimeString.toString(),
                "closeOn": datesofdays.toString(),
                "isFeatured": features.toString(),
                "owner": owner.text,
                "representative" : respresent.text,
                "imagePath": thimagelink
                };

            var response = await ApiCall().addRestaurant(data, '/addRestaurant');
            var body = json.decode(response.body);
             _showDone(body.toString());
            Navigator.pushReplacement(  
            context,
            new MaterialPageRoute(
            builder: (context) => AddmenuAdmin(id: body.toString() )));
   
     
    } else{
       _showDone("Fail Data Save.");
      print('Nope');
    

    } 
    }
    
setState(() {
     loading =false;
   });


  }
void _showDone(String message){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:Container(
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
      ),
    ); 
    },);
}

  
void _showDial( String message){
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
                    fontSize: 14.0,
                    fontFamily: 'OpenSans'
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
                          // toShowAddress = "$lat,$lng";
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
  final String hint;
  const NCard({this.active,this.icon,this.onTap,this.label,this.hint});
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
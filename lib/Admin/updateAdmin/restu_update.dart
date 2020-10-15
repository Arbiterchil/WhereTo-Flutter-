import 'dart:convert';
import 'dart:io';

import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_Restaurant.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_RestaurantResponse.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_RestaurantStream.dart';
import 'package:WhereTo/Admin/updateAdmin/text_editor.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../../styletext.dart';

class RestaurantUpdateNewTwo extends StatefulWidget {

  final int restaurantId;

  const RestaurantUpdateNewTwo({Key key, @required this.restaurantId}) : super(key: key);

  @override
  _RestaurantUpdateNewTwoState createState() => _RestaurantUpdateNewTwoState(restaurantId);
}

class _RestaurantUpdateNewTwoState extends State<RestaurantUpdateNewTwo> {

  final int restaurantId;

  _RestaurantUpdateNewTwoState(this.restaurantId);

  LatLng latlng = new LatLng(12.8797,121.7740);
String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";

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

  @override
  void initState() {
    print(widget.restaurantId);
    callBarangay();
    callCity();
    weekdays();
    _featured();
    super.initState();
    getRestaubyIds..getrestubyId(restaurantId);
  }

  

   String src;
   double lats ;
   double longs;
   String choseFrom;
  TextEditingController retaurantname  = TextEditingController();
    TextEditingController owner = TextEditingController(); 
    TextEditingController representative  = TextEditingController();
    TextEditingController newAddre = TextEditingController();
    TextEditingController contactnumber = TextEditingController();
    TextEditingController barangayId  = TextEditingController();
    TextEditingController cityId  = TextEditingController();
    TextEditingController openTimes  = TextEditingController();
    TextEditingController closingTimes = TextEditingController();
    TextEditingController closeOn = TextEditingController();
    TextEditingController featuredNow = TextEditingController();
    String imagepath;



    final formkey = GlobalKey<FormState>();
    String selectPerson;
    String opentimeString;
    String closetimeString;
    String datesofdays;
    String features;
    List dataBarangay = List();
     List citys = List();
    bool him = false;
    bool loading = false;
    bool loading1 = false;
    bool loading2 = false;
    
    final pick = ImagePicker();
   File _idPickerImage;
   String stringPath;
   var thimagelink;

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
    
     callBarangay() async{

    var respon = await ApiCall().getBararang('/getBarangayList');
    var bararang = json.decode(respon.body);
  
    setState(() {
      dataBarangay = bararang;
    });
    print(bararang);

  }

  callCity() async{
    var respon = await ApiCall().getBararang('/getCity');
    var bararang = json.decode(respon.body);
  
    setState(() {
      citys = bararang;
    });
    print(bararang);

  }

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
    }else if(src != null){
       return Container(
          width: 200,
        height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: pureblue,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(src))
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

  void makeItFeaturedRestu() async{
    setState(() {
      loading = true;
    });

    var makeItFea = await ApiCall().makeRestaurantFeatured('/makeRestaurantFeatured/${widget.restaurantId}');
    print(makeItFea.body);
    _showDial("Featuring Restaurant Success.");
    setState(() {
      loading = false;
    });

  }

  void updateRestu() async {
     setState(() {
      loading1 = true;
    });
    
    

    if(contactnumber.text == phoneValidate(contactnumber.text = contactnumber.text) ){
      _showDial("Wrong Contact Number Format");
    }else{

     if(formkey.currentState.validate()){
        formkey.currentState.save();
 if( _idPickerImage != null){
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
        }else{
           thimagelink = null;
       
        }
        var data = 
        { 
          'restaurantId': widget.restaurantId,
          'restaurantName' : retaurantname.text,
          'owner' : owner.text,
          'representative' : representative.text,
          // 'address' : newAddre.text != null ? newAddre.text : address.text,
           'latitude': lats.toString(),
          'longitude': longs.toString(),
          'barangayId' :  selectPerson == null ? barangayId.text : selectPerson.toString() ,
          'cityId' :  choseFrom == null ? cityId.text : choseFrom.toString() ,
          'contactNumber' : contactnumber.text,
          'openTime' : opentimeString == null ?  openTimes.text :  opentimeString,
          'closingTime' :closetimeString == null ? closingTimes.text   :  closetimeString.toString(),
          'closeOn' : datesofdays == null ? closeOn.text : datesofdays,
          'isFeatured' : features == null ? featuredNow.text :  features.toString(),
          'imagePath' :  thimagelink == null ? src.toString()  : thimagelink  ,
        };

        print(data);

      var updates = await ApiCall().updateRestaurant(data, '/updateRestaurant');
      print(updates.body);
      _showDial("Update Restaurant Success.");

     }else{
        _showDial("Something Went Wrong");

     }
    }
    setState(() {
      loading1 = false;
    });
  }

  void makeInActveRestu() async{


      var del = await ApiCall().deleteRestaurant('/deleteRestaurant/${widget.restaurantId}');
      print(del.body);
      _showDial("InActive Restaurant Success.");
  }

  @override
  void dispose() {
    
    super.dispose();
    getRestaubyIds..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: pureblue,
                                            borderRadius: BorderRadius.all(Radius.circular(50))
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.backspace,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                                _showDialogDelete("Are You Sure Want to make it In Active?"); 
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: pureblue,
                                            borderRadius: BorderRadius.all(Radius.circular(50))
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
          
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<RestaurantGetResponse>
                        (stream: getRestaubyIds.subject.stream,
                          builder: (context,AsyncSnapshot<RestaurantGetResponse> snaphot){
                               if(snaphot.hasData){
                if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                    return _error(snaphot.data.error);
                }
                  return _views(snaphot.data);
          }else if(snaphot.hasError){
                  return _error(snaphot.error);
          }else{
                  return _load();
        }
                        }),
                      ),

                      Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: makeItFeaturedRestu,
                                      child: Container(
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: pureblue
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                Icon(
                                                Icons.featured_play_list,
                                                color: pureblue,
                                                size: 20,
                                              ),
                                              Text( loading ? "...":"Make It Featured",
                                              style: TextStyle(
                                                color: pureblue,
                                                fontFamily: 'Gilroy-light',
                                                fontSize: 12
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),  
                        ),

                         Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: updateRestu,
                                      child: Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: pureblue
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                Icon(
                                                Icons.update,
                                                color: pureblue,
                                                size: 20,
                                              ),
                                              Text(loading1 ? "...":"Update Restaurant",
                                              style: TextStyle(
                                                color: pureblue,
                                                fontFamily: 'Gilroy-light',
                                                fontSize: 12
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),  
                        ),
                        
                        
                      ],
                    ),
                  ),
                   SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      onWillPop: () async => false),
      
    );
  }
    Widget _load(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }
    Widget _error(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Error :  $error")
              ],
            ),
          );
}

  Widget _views(RestaurantGetResponse restaurantGetResponse){
    RestaurantGets restaurantGets = restaurantGetResponse.restaurantGets;

     if(restaurantGets == null ){
          return Container(
            child: Text('Restaurant Detail NONE.',
            style: TextStyle(
              color:pureblue,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{
    //         if(restaurantGets == null){
    //  retaurantname.clear(); 
    // owner.clear();
    // representative.clear();
    //  barangayId.clear();
    //  contactnumber.clear();
    // //  openTimes.clear();
    // //  closingTimes.clear();
    //  closeOn.clear();

    //               } else{
                  //   retaurantname.text = restaurantGets.restaurantName;
                  // owner.text = restaurantGets.owner;
                  // representative.text = restaurantGets.representative;
                  
                  // contactnumber.text = restaurantGets.contactNumber.toString();
                  // lats = restaurantGets.latitude;
                  // longs = restaurantGets.longitude;
                  barangayId.text = restaurantGets.barangayId.toString();
                  cityId.text = restaurantGets.cityId.toString();
                  openTimes.text = restaurantGets.openTime;
                  closingTimes.text = restaurantGets.closingTime;
                  closeOn.text = restaurantGets.closeOn.toString();
                  //   src = restaurantGets.imagePath;
                  

                  featuredNow.text= restaurantGets.isFeatured.toString();
                  //  retaurantname.text = restaurantGets.restaurantName;
                  // owner.text = restaurantGets.owner;
                  // representative.text = restaurantGets.representative;
                  
                  // contactnumber.text = restaurantGets.contactNumber.toString();

                  // barangayId.text = restaurantGets.barangayId.toString();
                  // openTimes.text = restaurantGets.openTime;
                  // closingTimes.text = restaurantGets.closingTime;
                  // closeOn.text = restaurantGets.closeOn.toString();
                  //   src = restaurantGets.imagePath;
                  

                  // featuredNow.text= restaurantGets.isFeatured.toString();

                  // } 

           return Form(
             key: formkey,
                      child: Container(
                        child: Column(
                          children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10,),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 120,
                                        child: RaisedButton(
                                          child: Center(
                                            child: Text("Show Data.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light',

                                            ),
                                            ),
                                          ),
                                          color: pureblue,
                                          splashColor: Colors.amberAccent,
                                          onPressed: (){
                                            setState(() {
                                                retaurantname.text = restaurantGets.restaurantName;
                  owner.text = restaurantGets.owner;
                  representative.text = restaurantGets.representative;
                  
                  contactnumber.text = restaurantGets.contactNumber.toString();
                  lats = restaurantGets.latitude;
                  longs = restaurantGets.longitude;
                  barangayId.text = restaurantGets.barangayId.toString();
                  cityId.text = restaurantGets.cityId.toString();
                  openTimes.text = restaurantGets.openTime;
                  closingTimes.text = restaurantGets.closingTime;
                  closeOn.text = restaurantGets.closeOn.toString();
                    src = restaurantGets.imagePath;
                  

                  featuredNow.text= restaurantGets.isFeatured.toString();

                                            });
                                          }),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 120,
                                        child: RaisedButton(
                                          child: Center(
                                            child: Text("Clear Data.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light',
                                              
                                            ),
                                            ),
                                          ),
                                          color: pureblue,
                                          splashColor: Colors.amberAccent,
                                          onPressed: (){
                                            setState(() {
                                                retaurantname.text = restaurantGets.restaurantName;
                  owner.clear();
                  representative.clear();
                  contactnumber.clear();
                  retaurantname.clear();
                  barangayId.clear();
                  cityId.clear();
                  openTimes.clear();
                  closingTimes.clear();
                  closeOn..clear();
                  featuredNow.clear();

                                            });
                                          }),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                               _getImage(),
                               SizedBox(height: 10,),
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
                      SizedBox(height: 20,),
         TextEditGetter(
           iconic: Icons.perm_identity,
           validate: (val) => val.isEmpty ? ' Please Put The Owner\'s Name' : null,
           control: owner,
           hint: "Owner Name",
         ),
         SizedBox(height: 15,),
          TextEditGetter(
           iconic: Icons.person,
           validate: (val) => val.isEmpty ? ' Please Put The Representative\'s Name' : null,
           control: representative,
           hint: "Representative Name",
         ),
         SizedBox(height: 15,),
          TextEditGetter(
           iconic: Icons.restaurant,
           validate: (val) => val.isEmpty ? ' Please Put The Restaurant\'s Name' : null,
           control: retaurantname,
           hint: "Restaurant Name",
         ),
         SizedBox(height: 15,),
         FutureBuilder(
                  future: CoordinatesConverter().getAddressByLocation(lats.toString()+","+longs.toString()),
                  builder: (con ,snaps){
                    if(snaps.data == null){
                     return  NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: "Restaurant Address or Place",
                    onTap: () => viewMapo(),
                  );
                    }else{
                       return 
                 NCard(
                    active: false,
                    icon: Icons.my_location,
                    label: snaps.data,
                    onTap: () => viewMapo(),
                  )
                ;
                    }
                  },
                ),
  //        TextEditGetter(
  //            iconic: Icons.my_location,
  //            validate: (val) => val.isEmpty ? ' Please Put The Address' : null,
  //            control: him ? newAddre :address,
  //            hint: "Address Name",
  //            onTaps:  () {
  //               showModalBottomSheet(
  //   isDismissible: true,
  //   context: context, 
  // builder: (_){

  //   return SingleChildScrollView(
  //     physics: AlwaysScrollableScrollPhysics(),
  //     child: Column(
  //       children: [
  //         Container(
  //       height: 390,
  //       width: MediaQuery.of(context).size.width,
  //       child: PlacePicker(
  //                     apiKey: googleKey,
  //                     initialPosition: latlng,
  //                     useCurrentLocation: true,
  //                     searchForInitialValue: true,
  //                     usePlaceDetailSearch: true,
  //                     onPlacePicked: (result) async {
  //                       double lat = result.geometry.location.lat;
  //                       double lng = result.geometry.location.lng;
  //                       print("the Bilat is $lat and Oten is $lng");
  //                       setState(() {
  //                          lats = lat;
  //                       longs = lng;
  //                       });
  //                       Navigator.pop(context);
  //                       }
  //                   ),
  //     ),
  //       ],
  //     ),
  //   );

  // });
  //            },
  //        ),
          
         SizedBox(height: 15,),
          TextEditGetter(
           iconic: Icons.contacts,
          //  validate: (val)=> phoneValidate(contactnumber.text = val),
            // saved: (val) => contactnumber.text = val,
           control: contactnumber,
           hint: "Contact Number",
         ),
         SizedBox(height: 15,),
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
                            child: Icon(Icons.place,color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Barangay",
                                  style: TextStyle(
                                      
                                      color:pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: selectPerson == null ? barangayId.text : selectPerson,
                                  items: dataBarangay.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['barangayName'],
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
                                      selectPerson = item;
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
            SizedBox(height: 15,),
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
                            child: Icon(Icons.place,color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                            
                            
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select City",
                                  style: TextStyle(
                                      
                                      color:pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: choseFrom == null ? cityId.text : choseFrom,
                                  items: citys.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['cityName'],
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
                                      choseFrom = item;
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
        SizedBox(height: 15,),
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
                                  hint: Text( openTimes.text,
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
        SizedBox(height: 15,),
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
                                  hint: Text( closingTimes.text,
                                  style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
                                  value: closetimeString ,
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
        SizedBox(height: 15,), 
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
                                  
                                  value: datesofdays == null ? closeOn.text :  datesofdays,
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
                                  
                                  value: features == null ? featuredNow.text: features,
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
        SizedBox(height: 25.0,),
                      ],
                        ),
                      ));          
        }



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

void _showDialogDelete( String message){
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[     
                FlatButton(
                  color: Colors.white,
                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text ( "No", style :TextStyle(
                  color: pureblue,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),
                ),
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: makeInActveRestu,                         
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
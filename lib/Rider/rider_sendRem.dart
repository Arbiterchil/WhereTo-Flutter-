import 'dart:convert';
import 'dart:io';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider/rider_dash.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import '../styletext.dart';
import 'package:http/http.dart' as http;
class RiderRemit extends StatefulWidget {

  final String idFromLog;

  const RiderRemit({Key key, this.idFromLog}) : super(key: key);

  @override
  _RiderRemitState createState() => _RiderRemitState();
}

class _RiderRemitState extends State<RiderRemit> {


  File _idPickerImage;
  final pick = ImagePicker();
  var thimagelink;
  // var userData;
  var amountData;
  String stringPath;
  bool loading = false;
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
          width: 200,
        height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: pureblue
            ),
          ),
          child: Center(
            child: Icon(
              Icons.photo,
              size: 40,
              color: pureblue,
            ),
          ),
        );
    }


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
    });
    

  }

    @override
  void initState() {
      getAmount();
    // _getUserInfo();
    getAdminDevices();
      
    super.initState();

  } 

void getAmount() async{

    var response = await ApiCall().getRiderRemit('/getRiderRemit/${widget.idFromLog.toString()}');
  var bods = json.decode(response.body)['amount'];
  print(bods);
  setState(() {
    amountData = bods;
  });

}



// void _getUserInfo() async {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       var userJson = localStorage.getString('user');
//       var user = json.decode(userJson);
//       setState(() {
//         userData = user;
//       });
//   }
void sendRemitImage() async{
   setState(() {
     loading = true;
   });
   if(_idPickerImage == null){
      _showDialogError("Put your Screen Shot Image of Gcash or Union Bank.");

      setState(() {
     loading = false;
   });
   }else{
       sendToAdmin(); 
                        
   var viewthis = path.basename(_idPickerImage.path);
    CloudinaryClient client = new CloudinaryClient(
       "822285642732717",
       "6k0dMMg3As30mPmjeWLeFL5-qQ4",
       "amadpogi");
    await client.uploadImage( _idPickerImage.path ,filename: "Rider Remitance/$viewthis") .then((result){
         stringPath = result.secure_url;
          print(stringPath);
          thimagelink = stringPath;
      })
      .catchError((error) => print("ERROR_CLOUDINARY::  $error"));
var response = await ApiCall().getRiderRemit('/getRiderRemit/${widget.idFromLog.toString()}');
  var bods = json.decode(response.body)['id'];
  print(bods);
  var data=
  {
    "remitId":bods,
    "imagePath": thimagelink
  };
  await ApiCall().postRemitRider(data,'/riderRemit');
   await ApiCall().getOffline('/goOffline/${widget.idFromLog.toString()}');
                               SharedPreferences localStorage = await SharedPreferences.getInstance();
                               localStorage.remove('user');
                               localStorage.remove('token');
                               localStorage.remove('userTYPO');
                               localStorage.remove('menuplustrans');
                               var res = await ApiCall().getData('/logout');
                            var body = json.decode(res.body);
                           print(body);
                                Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),ModalRoute.withName('/'));
  _showDial("Send Done to the Admins.");
   }  
}
List allresult = [];
void getAdminDevices() async{
 var bods = await ApiCall().getAdminDevice('/getAllAdminDeviceId');
    List<dynamic> body = json.decode(bods.body);   
    for(int i = 0 ; i < body.length ;i++){
      allresult.add((body[i]['deviceId'].toString())); 
    }
    print(allresult);
}
void sendToAdmin() async{
   
  String url = 'https://onesignal.com/api/v1/notifications';
    var contents = {
      "include_player_ids": allresult,
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "A Rider Made a remit Please Check for the Amount."},
      "data": 
        {
        "force": "penalty"
        },
      "headings": {"en": "Rider Remit Notice:"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
    };
    var repo =
    await http.post(url, headers: headers, body: json.encode(contents));
    print(repo);
}


Widget loadingSpring() {

   return Container(
     height: MediaQuery.of(context).size.height,
     width: MediaQuery.of(context).size.width,
     child: Center(
        child: SpinKitCubeGrid(
          color: pureblue,
          size: 80.0,
        )
     ),
   );


 }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20 ,top: 10),
              child:
              loading ? 
              loadingSpring()
              : Column(
                children: <Widget>[
                    Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>
                      [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: GestureDetector(
                              onTap: () =>
                                Navigator.pushReplacement(context,
                           new MaterialPageRoute(builder: (context) => RiderProfile())),
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: pureblue,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Center(
                                  child: Text( 'Back <',
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
                        )
                      ],
                    ),
                ),
                    SizedBox(height: 40,),
                    RichText(text: 
                    TextSpan(
                      children: [

                        TextSpan(text :'Amount: ',
                          style: TextStyle(
                           color: pureblue,
                           fontFamily: 'Gilroy-light',
                           fontSize: 18, 
                          )
                        ),
                        TextSpan(text :amountData==null ?"...." :amountData.toString(),
                          style: TextStyle(
                           color: pureblue,
                           fontFamily: 'Gilroy-ExtraBold',
                           fontSize: 18, 
                          )
                        )

                      ]
                    ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                       Align(
                        alignment: Alignment.topLeft,
                        child:  GestureDetector(
                            onTap: sendRemitImage, 
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                               child:Text(loading ? "...." : "Send",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 15,
                                 fontFamily: 'Gilroy-light'
                               ),
                               ),
                              ),
                            
                          ),
                          ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: (){
                              getYourIdImage(ImageSource.gallery);
                            }, 
                            child: Container(
                              height: 40,
                              width: 190,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                               child: Text("Choose From Gallery",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontFamily: 'Gilroy-light',
                               ),
                               )
                              ),
                            ),
                          
                          ),
                      )
                    ],
                  ),
                ),
                    SizedBox(height: 20,),
                    _getImage(),
                    
                ],
              ),
            ),
          ),
        ), 
      onWillPop: () async => false),
      
    );
  }
  void _showDial(String message) {
    showDialog(
    context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
               message,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  // onPressed: () => Navigator.pushReplacement(context,
                  //          new MaterialPageRoute(builder: (context) => RiderProfile())),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
    );
  }
  void _showDialogError(String message) {
    showDialog(
    context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
                ),
                // Positioned(
                //   top: 50.0,
                //   left: 94.0,
                //   child: Container(
                //     height: 90,
                //     width: 90,
                //     padding: EdgeInsets.all(10.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(45),
                //       image: DecorationImage(
                //         image: AssetImage("asset/img/logo.png"),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
               message,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  // onPressed: () => Navigator.pushReplacement(context,
                  //          new MaterialPageRoute(builder: (context) => RiderProfile())),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
    );
  }
}
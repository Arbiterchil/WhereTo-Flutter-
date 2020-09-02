
import 'dart:convert';
import 'dart:io';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../../styletext.dart';

class RemitPendingUser extends StatefulWidget {

  final int id;

  const RemitPendingUser({Key key, this.id}) : super(key: key);

  get idFromLog => null;

  @override
  _RemitPendingUserState createState() => _RemitPendingUserState(id);
}

class _RemitPendingUserState extends State<RemitPendingUser> {
  final int id;

  _RemitPendingUserState(this.id);

  
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
    getAdminDevices();
    super.initState();
   
  }

  void getAmount() async{

    var response = await ApiCall().getRiderRemit('/getRiderRemit/$id');
  var bods = json.decode(response.body)['amount'];
  print(bods);
  setState(() {
    amountData = bods;
  });

}


void sendRemitImage() async{
   setState(() {
     loading = true;
   });
   if(_idPickerImage == null){
      _showDial("Put your Screen Shot Image of Gcash.");

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
  var data=
  {
    'remitId':bods,
    'imagePath': thimagelink
  };
   var valid = await ApiCall().postRemitRider(data,'/riderRemit');
  print(valid.body);

                                Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),ModalRoute.withName('/'));
                _showDial("Send Done to the Admins.");
   setState(() {
     loading =false;
   });
   }  
}
List allresult = [];

void getAdminDevices() async{
 var bods = await ApiCall().getAdminDevice('/getAllAdminDeviceId');
    List body = json.decode(bods.body);   
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
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
    };
    var repo =
    await http.post(url, headers: headers, body: json.encode(contents));
    print(repo);
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
              child: Column(
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
                                Navigator.pop(context),
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
                              width: 40,
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
                    "Yes",
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
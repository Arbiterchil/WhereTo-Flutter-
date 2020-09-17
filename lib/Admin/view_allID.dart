import 'dart:convert';
import 'dart:ui';

import 'package:WhereTo/Admin/User_Verification/user_getterres.dart';
import 'package:WhereTo/Admin/User_Verification/user_stream.dart';
import 'package:WhereTo/Admin/User_Verification/user_verifyclass.dart';
import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_imageda.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../styletext.dart';
class ViewAllImageId extends StatefulWidget {

  @override
  _ViewAllImageIdState createState() => _ViewAllImageIdState();
}


class _ViewAllImageIdState extends State<ViewAllImageId> {
  List url = List();
  var getThis;
  var sample;
  bool loading = true;
  bool barrier = false;
  // var consti = "https://661529868759591:6HJCxVBM8oUap_rIjqc24kKfR5w@api.cloudinary.com/v1_1/ddoiozfmr/resources/image/upload";
  
  // Future<List<Resources>>  getPhotos() async {
  //   return await http.get(consti).then((response) {
  //     Data an = Data.fromJson(json.decode(response.body.toString()));
  //     return an.resources;
     
  //   });

  
  // }
  
  @override
  void initState() {
      
    super.initState();
    userVerifying..getViewUnverified();
  }

  @override
  void dispose() {
    super.dispose();
    userVerifying..drainStream();
  }

  var constant;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 20,top: 10),
                   child: Container(
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
                           new MaterialPageRoute(builder: (context) => AdminDash())),
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
                 ),
                 SizedBox(height: 20.0,),
                Container(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<UserVerified>(

                      stream: userVerifying.subject.stream,
                      builder: (context, AsyncSnapshot<UserVerified> asyncSnapshot){
                        if(asyncSnapshot.hasData){
                            if(asyncSnapshot.data.error !=null && asyncSnapshot.data.error.length > 0){
                            return _error(asyncSnapshot.data.error);
                       }
                       return  _views(asyncSnapshot.data);       
                        }else if(asyncSnapshot.hasError){
                              return _error(asyncSnapshot.error);
                        }else{
                              return _load();
                        }
                      
                      
                      },

                    ),
                ), 
      
              ],
            ),
          )),
      ),
      
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
                    valueColor: AlwaysStoppedAnimation<Color>(pureblue),
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
  Widget _views(UserVerified userVerified){

      List<Unverified> un = userVerified.userView;

      if(un.length == 0 ){
          return Center(
            child: Container(
              child: Text('No Incomming to Verify',
              style: TextStyle(
                color: pureblue,
                fontFamily: 'Gilroy-ExtraBold',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),
            ),
          );
        }else{

            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:  new StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemBuilder: (context, index){
                   
                  return   GestureDetector(
                    onTap:  () {
                      _showDial(un[index].imagePath,un[index].userId,un[index].name);
                      }, 
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: FadeInImage.memoryNetwork(
                          // fadeInDuration: Duration(milliseconds: 1),
                          // fadeOutDuration: Duration(milliseconds: 1),
                          placeholder: kTransparentImage,
                           image: un[index].imagePath,
                           fit: BoxFit.cover,)

                      ),

                    ),
                  );

                },
                itemCount: un.length,
                staggeredTileBuilder: (index){
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                },),
              // child: GridView.builder(
              //   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //   shrinkWrap: false,
              //   itemCount: un.length,
              //   itemBuilder: (context, index){

              //     return GestureDetector(
              //       onTap: (){},
              //       // child: Container(
              //       //   child: Image.network(un[index].imagePath,
              //       //   fit: BoxFit.cover,),
              //       // ),
              //     child: Container(
              //       height: 215,
                    
              //       child: Card(
              //             elevation: 5.0,
              //             child: Column(
              //               children: <Widget>[
              //                 new ClipRRect(
              //                   borderRadius: BorderRadius.circular(4.0),
              //                   child: Hero(
              //                     tag: un[index].imagePath,
              //                     child: Image.network(
              //                       un[index].imagePath,
              //                       width: MediaQuery.of(context).size.width,
              //                       height: 208,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //       ),
              //     ),
              //     );

              //   },)
              );


        }

  }

  void sendNotiftoUserScammer(String id) async{

    var bods = await ApiCall().getDeviceUserScammer('/getUserDeviceId/${id.toString()}');
     await ApiCall().susVerify('/suspendAccount/${id.toString()}');
    var body = json.decode(bods.body);
    print(body[0]['deviceId']);
    String url = 'https://onesignal.com/api/v1/notifications';
    var contents = {
      "include_player_ids": [body[0]['deviceId'].toString()],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "You Are Violating our T&C so this Account Will be Terminate. "},
      "data": 
        {
        "force": "penalty"
        },
      "headings": {"en": "Admin Notice:"},
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
    print(repo.body);
    //  OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //             constant =notification.payload.additionalData; 
    //             print(constant['force']);
    // });
    
  }

  void _showDial(String resources, int id ,String name){

  
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child:Container(
          height: 450.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Colors.white),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(resources),
                    //   fit: BoxFit.fitWidth)
                  ),
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white,
                     borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    ),
                    imageProvider: NetworkImage(resources)),
                ),    
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'ID: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: id.toString(),
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                SizedBox(height: 10,),
                Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'Name: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: name,
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                SizedBox(height: 20,),
                 Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: GestureDetector(
                                onTap: () {
                                  
                                     ApiCall().postVerify('/verifyUser/${id.toString()}');
                                      print(id.toString());
                                   Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => AdminHomeDash()));
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: pureblue,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                    child: Text( 'Verify >',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                              ),
                          ),
                          
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5 ,left: 5),
                              child: GestureDetector(
                                onTap: () {
                                  
                                  
                                     sendNotiftoUserScammer(id.toString());
                                        
                                      print(id.toString());
                                      Navigator.pop(context);
                                  //  Navigator.pushReplacement(
                                  // context,
                                  // new MaterialPageRoute(
                                  //     builder: (context) => AdminHomeDash()));
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: pureblue,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                    child: Text(' Suspend >',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
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
                   ),
                ],
            ),
          ),
        )
    ),
      ); 
    },);


}

}


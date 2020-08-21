import 'dart:convert';
import 'package:WhereTo/AnCustom/dialogHelp.dart';
import 'package:WhereTo/Rider/rider_sendRem.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/dummy_Card.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderDash extends StatefulWidget {
  @override
  _RiderDashState createState() => _RiderDashState();
}

class _RiderDashState extends State<RiderDash> {
var userData;
 bool online = true;
  String coma = "'";
  var checkbool;
  @override
  void initState() {
    // configSignal();
    _getUserInfo();
    postRiderId();
    super.initState();
    
  }

void postRiderId() async{
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    var data =
    {
      "userId" : userData['id'].toString(),
      "playerId" : playerId
    };
    var responses = await ApiCall().playerIdSave(data,'/assignPlayerId');
    print(responses);
  }
void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      checkbool = localStorage.getBool('check'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }
void goOffline() async{
   await ApiCall().getOffline('/goOffline/${userData['id']}');
}
void goOnline() async{
 var data = {
        'contactNumber' : userData['contactNumber'].toString(), 
        'password' : userData['password'].toString()
        ,};
    


  await ApiCall().postData(data,'/login');


}

void toOnline(bool e) async{


    setState(() {

      if(e){
        online = e;     
        // goOnline();
        
        }else{
        online = e;
        goOffline();
      }
      

      
    });

}

void configSignal() async {
  await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
  
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                  
                  decoration: BoxDecoration(
                    color: pureblue,
                    boxShadow: [
               BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
            ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SharedPrefCallnameData(),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Container(
                          height: 70,
                          width: 90,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                          ],
                          ),
                          child: Center(
                            child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ratings: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
            ),
            
            TextSpan(
              text: '4.5',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy-ExtraBold'
              ),
            ),
          ],
        ),
      ) ,
                          ),
                        ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => RiderRemit()));
                      },
                      child: Container(
                            height: 70,
                            width: 90,
                            decoration: BoxDecoration(
                              color: pureblue,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                               BoxShadow(
                                 color: Colors.black12,
                                 spreadRadius: 3.3,
                                 blurRadius: 3.3
                               ),
                            ],
                            ),
                            child: Center(
                              child: Text('1140',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 18
                              ),
                              ),
                            ),
                          ),
                    ),
                    Container(
                          height: 70,
                          width: 90,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                          ],
                          ),
                          child: Center(
                            child: Switch(
                                        value: online,
                                        activeColor: Colors.lightGreen,
                                        // onChanged: ((bool e)=>toOnline(e)),
                                        onChanged: (bool value) async {
                                         
                                              online = !value;
                                                 
                                                Dialog_Helper.exit(context); 
                                           
                                         }, 
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: pureblue,
                    boxShadow: [
               BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
            ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.star,size: 25,color: Colors.amber,),
                                       Icon(Icons.star,size: 25,color: Colors.amber,),
                                        Icon(Icons.star,size: 25,color: Colors.amber,),
                                         Icon(Icons.star,size: 25,color: Colors.amber,),
                                          Icon(Icons.star_half,size: 25,color: Colors.amber,),
                                    ],
                                  ),
                  ),
                ),
                 SizedBox(height: 15,),
                 DontenNoMichi(
                              boldName: "Admin: Erchil Amad",
                              subtitle: "Hi. Rider .",
                              description: "$coma A Reminder and Also a Heed that please be true on your work of Delivery And Good Speed. $coma",
                            ),
                            SizedBox(height: 15,),
                            DontenNoMichi(
                              boldName: "Admin : Jayce Mico",
                              subtitle: "For more Info",
                              description: "$coma Hi. if you're a new Rider feel Free to ask on our marketing staff to answer your Questions and God bless.$coma",
                            ),
                            
              ],
            ),
          ),
        ),
      ),
    );
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
        height: 30.0,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.white,size: 15.0,),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'
                      ),),
                    ),
                  ),
             ),
           
            
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'dart:ui';
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
  bool  load = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController ownconpass = TextEditingController();

  TextEditingController ownpass = TextEditingController();

  @override
  void initState() {
    configSignal();
    super.initState();
    _getUserInfo();
    postRiderId();
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
    print(responses.body);
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
    await OneSignal.shared.getPermissionSubscriptionState();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: pureblue
                    ),
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
                             border: Border.all(
                      width: 1,
                      color: pureblue
                    ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ratings: ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
            ),
            
            TextSpan(
              text: '4.5',
              style: TextStyle(
                color: pureblue,
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
                  
                    Container(
                          height: 70,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                      width: 1,
                      color: pureblue
                    ),
                          ),
                          child: Center(
                            child: Switch(
                                        value: online,
                                        activeColor: pureblue,
                                        // onChanged: ((bool e)=>toOnline(e)),
                                        // onChanged: (bool value) async {
                                         
                                        //       // online = !value;
                                                 
                                        //         // Dialog_Helper.exit(context); 
                                           
                                        //  }, 
                                         onChanged: (bool value) async {
                                           
                                              // online = !value;
                                                //  Navigator.pushReplacement(context,
                // new MaterialPageRoute(builder: (context) => RiderRemit()));
                                                // Dialog_Helper.exit(context); 
                                           
                                         }, 
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
            //     Container(
            //       height: 80,
            //       decoration: BoxDecoration(
            //         color: pureblue,
            //         boxShadow: [
            //    BoxShadow(
            //                    color: Colors.black12,
            //                    spreadRadius: 5.5,
            //                    blurRadius: 5.5
            //                  ),
            // ],
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 20,right: 20),
            //         child: Row(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: <Widget>[
            //                           Icon(Icons.star,size: 25,color: Colors.amber,),
            //                            Icon(Icons.star,size: 25,color: Colors.amber,),
            //                             Icon(Icons.star,size: 25,color: Colors.amber,),
            //                              Icon(Icons.star,size: 25,color: Colors.amber,),
            //                               Icon(Icons.star_half,size: 25,color: Colors.amber,),
            //                         ],
            //                       ),
            //       ),
            //     ),
                 SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    print(userData['id'].toString());
                    showDialogFam(userData['id'].toString());

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: pureblue
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text("Change Password",
                      style: TextStyle(
                        color: pureblue,
                        fontFamily: 'Gilroy-light',
                        fontSize: 18
                      ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                Text("Note:",style: TextStyle(color:pureblue,fontFamily: 'Gilroy-ExtraBold',fontSize: 30),),
                SizedBox(height: 25,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                         text: '1. ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: 'Before you to logout you will be redirect to remit page for your conpensation to use this app as a renowned Rider of Whereto.',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                    ]
                  ) ),
                  SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                         text: '2. ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: 'When Accepting a Transaction Please be truthfull on delivery as you our Rider and trustfull companion.',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                    ]
                  ) ),
                  SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                         text: '3. ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: ' When you have problem in logging in with Messages like',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                      TextSpan(
                         text: ' Have a Pending Remit ',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: 'is that the admin still checking the remit you have sent.',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                    ]
                  ) )  ,               
                 SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                         text: '4. ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: 'If you\'re Account is ',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                      TextSpan(
                         text: 'Suspended',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: ' Due to wrong amount or some Activties you commit that you made a mistake you can go to the Office to tell us the details and youcan also consult on what really happen.Also the Account you have now is on Admin Hands to decide.',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                    ]
                  ) ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                         text: '5. ',
              style: TextStyle(
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-ExtraBold'
              ),
                      ),
                      TextSpan(
                         text: 'Lastly have Fun and Enjoy Riding. God Speed and Thank You',
                      
              style: TextStyle(
                
                color: pureblue,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
                      ),
                    ]
                  ) ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogFam(String id){

    showDialog(context: context,
    barrierDismissible: true,
    builder: (context){
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       SizedBox(
                  height: 15.0,
            ),
            Text(
                  'New Password',
                  style: eLabelStyle,
            ),
            SizedBox(
                  height: 10.0,
            ),
            Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  decoration: eBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    cursorColor: pureblue,
                    controller: ownpass,
                    validator: (input) =>
                        ownpass.text.length < 8 ? 'Password to Short' : null,
                    obscureText: true,
                    style: TextStyle(
                      color: pureblue,
                      fontFamily: 'Gilroy-light',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: pureblue,
                      ),
                      hintText: '********',
                      hintStyle: eHintStyle,
                    ),
                  ),
            ),
           SizedBox(
                  height: 15.0,
            ),
            Text(
                  'Confirm Password',
                  style: eLabelStyle,
            ),
            SizedBox(
                  height: 10.0,
            ),
            Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  decoration: eBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    cursorColor: pureblue,
                    controller: ownconpass,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Input Confirm Password";
                      }
                      if (val != ownpass.text) {
                        return "Password not Match";
                      }
                      return null;
                    },
                    obscureText: true,
                    style: TextStyle(
                      color: pureblue,
                      fontFamily: 'Gilroy-light',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: pureblue,
                      ),
                      hintText: '********',
                      hintStyle: eHintStyle,
                    ),
                  ),
            ),

            SizedBox(height: 20,),
            GestureDetector(
              onTap: () async{
                    setState(() {
                      load = true;
                    });

                    if(formkey.currentState.validate()) {
                        formkey.currentState.save();
                        var data = {
                    "userId": id,
                    "password": ownpass.text 
                  };
                  var respon = await ApiCall().changepasssword(data,'/changePassword');
                  print(respon.body);
                   Navigator.pop(context);
                  _showDistictWarning("Password Change");
                 
                    }else{
                      _showDistictWarning("Password Not Match");
                    }
                  

                  setState(() {
                    load = false;
                  });

              },
              child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: pureblue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Center(
                    child: Text(load ? "..." : "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Gilroy-light'
                    ),),
                  ),
              ),
            ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      );
    }
    );

    }
    void _showDistictWarning(String meesage) {
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
              child: Text(
                meesage,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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

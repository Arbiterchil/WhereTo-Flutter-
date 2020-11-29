// import 'dart:convert';
// import 'dart:html';
import 'dart:ui';

import 'package:WhereTo/A_loadingSimpe/adminDialogCity.dart';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/AddCityfran/city_forms.dart';
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/baraneditform.dart';
import 'package:WhereTo/Admin/Admin_Biew/adminViewfin.dart';
import 'package:WhereTo/Admin/Restaurant.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_RemitImages.dart';
import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/trialSearch/enter.dart';
import 'package:WhereTo/Admin/trialSearch/trial_saerch.dart';
import 'package:WhereTo/Admin/view_allID.dart';
import 'package:WhereTo/Admin/view_saleOurs/show_resultsRemitList.dart';
import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/styletext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDash extends StatefulWidget {
  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {

  final scaffoldKey = new GlobalKey<ScaffoldState>(); 

  var userData;
  bool  load = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController ownconpass = TextEditingController();

  TextEditingController ownpass = TextEditingController();
  TextEditingController search_data = TextEditingController();
  String name = "";
  String img = "";
  String con = "";
  bool icon = false;
  bool icon2 = true;
  String pass;
  @override
  void initState() {
  _getUserInfo();
    super.initState();
    
  }

  void _getUserInfo(){

    name = UserGetPref().getUserDataJson['name'];
    img = UserGetPref().getUserDataJson['imagePath'];
    con = UserGetPref().getUserDataJson['contactNumber'];

    print("$name and $img");

    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var userJson = localStorage.getString('user');
    // var user = json.decode(userJson);
    // setState(() {
    //   userData = user;
    // });

  }
  void getifHaveCity() async{
    var ok  = UserGetPref().idSearch;
    if(ok != null ){
      print("can Proceed");
       setState(() {
                                        icon = true;
                                        icon2 = false;
                                        pass = search_data.text;
                                      });
    }else{
      print("Can't Please Select City");
      showDialog(context: context,
       barrierDismissible: true,
       builder: (context) =>AdminLocationCity(),
       ); 
    }


  }

  

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2.2,
                        blurRadius: 3.3,
                        color: Colors.grey[300]
                      )
                    ]
                  ),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10) ,
                          child: Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: wheretoDark,
                                        fontFamily: "Gilroy-ExtraBold",
                                        fontSize: 30                                      ),
                                      ),
                                      SizedBox(height: 5,),
                                       Text("ADMIN",
                                      style: TextStyle(
                                        color: wheretoDark,
                                        fontFamily: "Gilroy-light",
                                        fontSize: 16                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: wheretoDark,
                                      width: 2
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(img),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                          child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                        showDialog(context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>AdminLocationCity(),
                                        );
                                    },
                                    child: Icon( Icons.location_on,
                                    size: 30,
                                    color: wheretoDark,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                           var ok  = UserGetPref().idSearch;
                              if(ok != null ){
                                 Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => AdminViewer()));
                 print("have");
                               }else{ showDialog(context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>AdminLocationCity(),
                                        );
                                        print("none");
                               }
                                    },
                                    child: Icon( Icons.remove_red_eye_sharp,
                                    size: 30,
                                    color: wheretoDark,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                Expanded(
                                  // child: GestureDetector(
                                  //   onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  EnterChoseFirst() )),
                                  //   child: Container(
                                  //     height: 40,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.all(Radius.circular(50)),
                                  //       border: Border.all(
                                  //         width: 2,
                                  //         color: wheretoDark
                                  //       )
                                  //     ),
                                  //     child: Center(
                                  //       child: Text("Search Edit Data",
                                  //       style: TextStyle(
                                  //         color: wheretoDark,
                                  //         fontFamily: 'Gilroy-light',
                                  //         fontSize: 12,
                                  //       ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )),
                                  child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2,color: wheretoDark),
              ),
              height: 50.0,
              child: TextFormField(
                controller: search_data,
                keyboardType: TextInputType.text,
                cursorColor: wheretoDark,
                style: TextStyle(
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left:14.0),
                  // prefixIcon: Icon(
                  //   Icons.phone_android,
                  //   color: pureblue,
                  // ),
                  hintText: 'Search Restaurant',
                  hintStyle: TextStyle(
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                ),
                ),
              ),
            ),
                                ),
                                  SizedBox(width: 20,),
                                Visibility(
                                  visible: icon2,
                                  child: GestureDetector(
                                    onTap: (){
                                     
                                      getifHaveCity();
                                    },
                                    child: Icon( Icons.search ,
                                    size: 30,
                                    color: wheretoDark,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: icon,
                                  child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                        icon = false;
                                         icon2 = true;
                                         pass = "";
                                         search_data.text = "";
                                      });
                                  },
                                  child: Icon(Icons.clear,
                                  size: 30,
                                  color: wheretoDark,
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,bottom: 10),
                          child: Container(
                            height: 28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 4,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: wheretoDark,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(height: 4,),
                                 Container(
                                  height: 4,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: wheretoDark,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Visibility(
                  visible: icon,
                  child: SearchforAdmin(
                    fromAdminSearch: pass,

                  )),
                SizedBox(height: 15,),
                Visibility(
                  visible: icon2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("Daily Life Procedure",
                    style: TextStyle(
                      color: wheretoDark,
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 14
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Visibility(
                  visible: icon2,
                  child: Container(
                    height: 510,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: EdgeInsets.all(8),
                        primary: false,
                        crossAxisCount: 2,
                        children: 
                        [
                          
                           Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.shield,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Verify",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 14
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed:() =>Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ViewAllImageId()))),
                          ),
                           Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                               child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.checkmarkCircle,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Approve Remit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 14
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed: (){
                                var ok  = UserGetPref().idSearch;
                              if(ok != null ){
                                  Navigator.pushReplacement(context,
                 new MaterialPageRoute(builder: (context) => RemitViewImagesAdmin()));
                 print("have");
                               }else{ showDialog(context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>AdminLocationCity(),
                                        );
                                        print("none");
                               }
                              })
                //               onPressed: () => Navigator.pushReplacement(context,
                //  new MaterialPageRoute(builder: (context) => RemitViewImagesAdmin()))),
                          ),
                           Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                               child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.list,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Remittance List",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 14
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed: (){
                                var ok  = UserGetPref().idSearch;
                              if(ok != null ){
                                 Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ShowemitListResult()));
                 print("have");
                               }else{ showDialog(context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>AdminLocationCity(),
                                        );
                                        print("none");
                               }
                              })
                //               onPressed:() => Navigator.pushReplacement(context,
                // new MaterialPageRoute(builder: (context) => ShowemitListResult()))),
                          ),
                           Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                               child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.swap,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Change Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 12
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed: () => showDialogFam(UserGetPref().getUserDataJson['id'].toString())),
                          ),
                           Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                               child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_city_rounded,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Add City",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 12
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_)=> SeacrhFormCitywithAdd())
                              // PageRouteBuilder(
                              //   transitionDuration: Duration(seconds: 1),
                              //   transitionsBuilder: (context,animation,animationtime,child){
                              //     animation = CurvedAnimation(
                              //       parent: animation,
                              //       curve: Curves.elasticInOut,
                              //     );
                              //     return ScaleTransition(
                              //       alignment: Alignment.bottomLeft,
                              //       scale: animation,
                              //       child: child,
                              //       );
                              //   },
                              //   pageBuilder: (context,animation,animationtime){
                              //     return SeacrhFormCitywithAdd(); 
                              //   }),
                              )
                              )
                          ),

                          Container(
                            height: 100,
                            width: 100,
                            child: RaisedButton(
                              splashColor: Colors.indigo[300],
                              color: wheretoDark,
                               child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.track_changes_rounded,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8,),
                                    Text("Edit Charges",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 12
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              onPressed: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_)=> BaranggaySearchChrage())
                              // PageRouteBuilder(
                              //   transitionDuration: Duration(seconds: 1),
                              //   transitionsBuilder: (context,animation,animationtime,child){
                              //     animation = CurvedAnimation(
                              //       parent: animation,
                              //       curve: Curves.elasticInOut,
                              //     );
                              //     return ScaleTransition(
                              //       alignment: Alignment.bottomLeft,
                              //       scale: animation,
                              //       child: child,
                              //       );
                              //   },
                              //   pageBuilder: (context,animation,animationtime){
                              //     return SeacrhFormCitywithAdd(); 
                              //   }),
                              )
                              )
                          ),
                        ],
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              
              ],
            ),
          )),
      onWillPop:() async => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => 
          DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "Do you want to exit app?",
        message: "Please double check for the Remits of Riders before Exiting",
        buttTitle1: "Yes",
        buttTitle2: "No",
        yesFunc: () =>authShared.logRemoveAll(context),
        noFunc: () => Navigator.pop(context),
        showorNot1: true,
        showorNot2: true,
      ),),
      ),
    );
  }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       // backgroundColor: Color(0xFFF7F7F7),
//       // backgroundColor: Color(0xFF0C375B),
//       body: WillPopScope(
        
//           child: SafeArea(
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                    Padding(
//                       padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
//                       child: Container(
//                         height: 140,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1,
//                             color: pureblue
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child:Center(
//                           child: SharedPrefCallnameData(),
//                         )
//                       ),
//                       ),
//                     SizedBox(height: 10,),
                    
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                           Container(
//                             height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                             width: 1,
//                             color: pureblue
//                           ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Admins",
//                               style: TextStyle(
//                                 color:  pureblue,
//                                 fontFamily: 'Gilroy-light',
//                                 fontSize: 16,
//                               ),),
//                               SizedBox(height: 10,),
//                               Text("?",
//                               style: TextStyle(
//                                 color:  Colors.amber,
//                                 fontFamily: 'Gilroy-ExtraBold',
//                                 fontSize: 16,
//                               ),),
//                             ],
//                           ),
//                           ),

//                           Container(
//                             height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                              border: Border.all(
//                             width: 1,
//                             color: pureblue
//                           ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
                          
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Users",
//                               style: TextStyle(
//                                 color:  pureblue,
//                                 fontFamily: 'Gilroy-light',
//                                 fontSize: 16,
//                               ),),
//                               SizedBox(height: 10,),
//                               Text("?",
//                               style: TextStyle(
//                                 color:  pureblue, 
//                                 // Color(0xFF0C375B),
//                                 fontFamily: 'Gilroy-ExtraBold',
//                                 fontSize: 16,
//                               ),),
//                             ],
//                           ),
//                           ),

//                           Container(
//                             height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                              border: Border.all(
//                             width: 1,
//                             color: pureblue
//                           ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
                        
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Riders",
//                               style: TextStyle(
//                                 color:pureblue,
//                                 fontFamily: 'Gilroy-light',
//                                 fontSize: 16,
//                               ),),
//                               SizedBox(height: 10,),
//                               Text("?",
//                               style: TextStyle(
//                                 color:  Colors.deepOrange,
//                                 fontFamily: 'Gilroy-ExtraBold',
//                                 fontSize: 16,
//                               ),),
//                             ],
//                           ),
//                           ),
                          
//                           ],
//                         ),
                      
//                       ),
//                       SizedBox(height: 40,),
//                     ButtonAdmins(
//                       icon: EvaIcons.shield,
//                       namebutton: "Verify User Valid ID.",
//                       ontap: () =>Navigator.pushReplacement(context,
//                 new MaterialPageRoute(builder: (context) => ViewAllImageId())),
//                     ),
//                     SizedBox(height: 30,),
//                     ButtonAdmins(
//                       icon: EvaIcons.checkmark,
//                       namebutton: "Approve Remittance.",
//                       ontap: () => Navigator.pushReplacement(context,
//                 new MaterialPageRoute(builder: (context) => RemitViewImagesAdmin())),
//                     ),
//                      SizedBox(height: 30,),
//                     ButtonAdmins(
//                       icon: EvaIcons.list,
//                       namebutton: "Remittance List.",
//                       ontap: () => Navigator.pushReplacement(context,
//                 new MaterialPageRoute(builder: (context) => ShowemitListResult())),
//                     ),
//                   SizedBox(height: 20,),
//                   Padding(padding: const EdgeInsets.only(left: 30,right: 30),
//                   child: Text("Note : ",
//                   style: TextStyle(
//                     color: pureblue,
//                     fontFamily: 'Gilroy-ExtraBold',
//                     fontSize: 30
//                   ),
//                   ),
//                   ),
//                   SizedBox(height: 20,),
//                   Padding(padding: const EdgeInsets.only(left: 30,right: 30),
//                   child: RichText(text: TextSpan(
//                     children: [

//                       TextSpan(
//                         text: "1. ",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-ExtraBold',
//                           fontSize: 12
//                         )
//                       ),
//                        TextSpan(
//                         text: "Please Check Time to Time if there's a New User to Verify.",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-light',
//                           fontSize: 12
//                         )
//                       ),

//                     ]
//                   ))
//                   ),
//                   SizedBox(height: 10,),
//                    Padding(padding: const EdgeInsets.only(left: 30,right: 30),
//                   child: RichText(text: TextSpan(
//                     children: [

//                       TextSpan(
//                         text: "2. ",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-ExtraBold',
//                           fontSize: 12
//                         )
//                       ),
//                        TextSpan(
//                         text: "Also Watch Over the Remittance View if the rider made a mistake.",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-light',
//                           fontSize: 12
//                         )
//                       ),

//                     ]
//                   ))
//                   ),
//                   SizedBox(height: 10,),
//                    Padding(padding: const EdgeInsets.only(left: 30,right: 30),
//                   child: RichText(text: TextSpan(
//                     children: [

//                       TextSpan(
//                         text: "3. ",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-ExtraBold',
//                           fontSize: 12
//                         )
//                       ),
//                        TextSpan(
//                         text: "Don't Sleep on Working Hours",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-light',
//                           fontSize: 12
//                         )
//                       ),

//                     ]
//                   ))
//                   ),
//                    SizedBox(height: 10,),
//                    Padding(padding: const EdgeInsets.only(left: 30,right: 30),
//                   child: RichText(text: TextSpan(
//                     children: [

//                       TextSpan(
//                         text: "4. ",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-ExtraBold',
//                           fontSize: 12
//                         )
//                       ),
//                        TextSpan(
//                         text: "If You have Problems to Report Just Contact our Owner.",
//                         style: TextStyle(
//                           color: pureblue,
//                           fontFamily: 'Gilroy-light',
//                           fontSize: 12
//                         )
//                       ),

//                     ]
//                   ))
//                   ),
//                    SizedBox(height: 40,),
//                     Row(
//                       children: [
//                         Padding(
//                       padding: const EdgeInsets.only(left: 30),
//                       child: GestureDetector(

//                                   onTap: (){
//                                       print(userData['id'].toString());
//                                       showDialogFam(userData['id'].toString());
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: 140,
//                                     decoration: BoxDecoration(
//                                       color: pureblue,
//                                       borderRadius: BorderRadius.all(Radius.circular(40)),
//                                     ),
//                                     child: Center(
//                                       child: Text("Change Password",
//                                       style: TextStyle(
//                                         color:  Colors.white,
//                                         fontSize: 14,
//                                         fontFamily: 'Gilroy-light'
//                                       ),
//                                       ),
//                                     ),
//                                   ),

//                                 ),
//                     ),
//                      Padding(
//                       padding: const EdgeInsets.only(left: 30),
//                       child: GestureDetector(

//                                   onTap: (){
//                                     // Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditRestaurant()));
//                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  EnterChoseFirst() ));
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: 140,
//                                     decoration: BoxDecoration(
//                                       color: pureblue,
//                                       borderRadius: BorderRadius.all(Radius.circular(40)),
//                                     ),
//                                     child: Center(
//                                       child: Text("Edit Restaurants",
//                                       style: TextStyle(
//                                         color:  Colors.white,
//                                         fontSize: 14,
//                                         fontFamily: 'Gilroy-light'
//                                       ),
//                                       ),
//                                     ),
//                                   ),

//                                 ),
//                     ),
//                       ],
//                     ),
//                    SizedBox(height: 20,),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 30),
//                       child: RaisedButton(
//                   splashColor: Colors.amberAccent,
//                  color: Color(0xFF0C375B),
//                   shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0)),
//                   onPressed: () =>showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) => 
//           DialogForAll(
//         widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
//         labelHeader: "Do you want to exit app?",
//         message: "Please double check for the Remits of Riders before Exiting",
//         buttTitle1: "Yes",
//         buttTitle2: "No",
//         yesFunc: () => authShared.logRemoveAll(context),
//         noFunc: () async => Navigator.pop(context),
//         showorNot1: true,
//         showorNot2: true,
//       ),) ,
//                   child: Text(
//                       "Log Out",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12.0,
//                           fontFamily: 'OpenSans'),
//                   ),
//                   ),
//                     ),
//                    SizedBox(height: 10,),
//                 ],
//               ),
//             ),
//             ),
        
//        onWillPop:() async => showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) => 
//           DialogForAll(
//         widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
//         labelHeader: "Do you want to exit app?",
//         message: "Please double check for the Remits of Riders before Exiting",
//         buttTitle1: "Yes",
//         buttTitle2: "No",
//         yesFunc: () =>authShared.logRemoveAll(context),
//         noFunc: () => Navigator.pop(context),
//         showorNot1: true,
//         showorNot2: true,
//       ),)
//       ),
//     );
//   }


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

class ButtonAdmins extends StatelessWidget{
  
  final Function ontap;
  final String namebutton;
  final IconData icon;

  const ButtonAdmins({Key key, this.ontap, this.namebutton, this.icon}) : super(key: key); 
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: pureblue,
              ),
              SizedBox(width: 15,),
              Text(namebutton,
              style: TextStyle(
                color: pureblue,
                fontSize: 14,
                fontFamily: 'Gilroy-light'
              ),
              )
            ],
          ),
        ),
      ),
    );

  }




}
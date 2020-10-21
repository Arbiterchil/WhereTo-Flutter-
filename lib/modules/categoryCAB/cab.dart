import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/CityLocal/cityStream.dart';
import 'package:WhereTo/CityLocal/cityclass.dart';
import 'package:WhereTo/CityLocal/cityresponse.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../styletext.dart';

class FirstPageForRegUser extends StatefulWidget {
  @override
  _FirstPageForRegUserState createState() => _FirstPageForRegUserState();
}

class _FirstPageForRegUserState extends State<FirstPageForRegUser> {

  

  @override
  void initState() {
    super.initState();
    cityStream..getCity();
    bararangStream..getBarangayListFormDb();
  }

  @override
  void dispose() {
    super.dispose();
    cityStream..drainStream();
    bararangStream..drainStreamData();
  }

  String selectedCity;
  String selectedbaranggayTagum;
  TextEditingController delAdd = TextEditingController();
  bool open = false;


  Widget getCity() {
    return StreamBuilder<CityResponses>(
      stream: cityStream.subject.stream,
      builder: (context,AsyncSnapshot<CityResponses> asyncSnapshot){
        if(asyncSnapshot.hasData){
          if(asyncSnapshot.data.error != null && asyncSnapshot.data.error.length > 0){
               return _errorTempMessage(asyncSnapshot.data.error);
          }
          return _view(asyncSnapshot.data);
        }else if(asyncSnapshot.hasError){
          return _errorTempMessage(asyncSnapshot.data.error);
        }else{
          return _loading();
        }
      },
    );
  }

  Widget _view(CityResponses cityResponses){
    List<CityLocals> cl = cityResponses.citys;
    if(cl.length == 0){
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
                                    "Select City",
                                    style: TextStyle(
                                        color: Color(0xFF0F75BB),
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                   dropdownColor: Colors.white,
                                   icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:Color(0xFF0F75BB),
                                  ),
                                
                             items: cl.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.cityName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value:selectedCity,
                               
                             onChanged: (val){
                                // setState(()=>selectedCity = val);
                              setState(() {
                                selectedCity = val;
                                if(selectedCity == "1"){
                                  print("Tagum");
                                  open = true;
                                }else{
                                  print("Tacloban");
                                  open = false;
                                }
                              });
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

  Widget getBaranggaytagum(){
      return StreamBuilder<BaranggayRespone>(
      stream: bararangStream.subject.stream,
      builder: (context,AsyncSnapshot<BaranggayRespone> asyncSnapshot){
        if(asyncSnapshot.hasData){
          if(asyncSnapshot.data.error != null && asyncSnapshot.data.error.length > 0){
               return _errorTempMessage(asyncSnapshot.data.error);
          }
          return _view1(asyncSnapshot.data);
        }else if(asyncSnapshot.hasError){
          return _errorTempMessage(asyncSnapshot.data.error);
        }else{
          return _loading();
        }
      },
    );
  } 

  Widget _view1(BaranggayRespone respone){
     List<Barangays> bl = respone.bararangSaika;
    if(bl.length == 0){
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
                                
                             items: bl.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.barangayName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value:selectedbaranggayTagum,
                               
                             onChanged: (val){
                                setState(()=>selectedbaranggayTagum = val);
                              
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30), 
              child: Column(
                children: [
                    SizedBox(height: 15,),
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("asset/img/logo.png"), 
                          )
                      ),
                    ),
                   SizedBox(height: 25,),
                  getCity(),
                  SizedBox(height: 15,),
                  Visibility(
                    visible: open,
                    child: getBaranggaytagum()),
                     SizedBox(height: 15,),
                      Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: delAdd,
                validator: (val) => val.isEmpty ? ' Please Put Delivery Address' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    EvaIcons.map,
                    color: pureblue,
                  ),
                  hintText: 'Delivery Address',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
                    SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text("Browse Now.",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gilroy-light"
                        ),
                        ),
                      ),
                      splashColor: wheretoDark,
                      color: pureblue,
                      onPressed: ()=>navigatepage()),
                  ),
                ],
              ),
              ),

          ) ,
      onWillPop: () async => false),
    );
  }

  void navigatepage() async{ 

    if(selectedCity == null){
      showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice :",
        message: "Please Select City and put your address.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else{
      if(selectedCity == "1"){

      if(selectedbaranggayTagum == null){
           showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice :",
        message: "Please Select Barangay",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
      }else if(delAdd.text.isEmpty){
         showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice :",
        message: "Please input some Delivery Address before proceeding.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
      }else{

        print("Sulod");
        UserGetPref().cityId(selectedCity);
        UserGetPref().userDataSave("page");
        await authShared.forUsersOnly( selectedCity, selectedbaranggayTagum, delAdd.text);
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=> HomePage() ));
      }  

    }else{
        print("OnGoing");
    }


    }

    
  }

}
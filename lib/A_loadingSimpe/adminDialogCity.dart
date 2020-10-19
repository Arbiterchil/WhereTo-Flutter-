import 'dart:ui';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/CityLocal/cityStream.dart';
import 'package:WhereTo/CityLocal/cityclass.dart';
import 'package:WhereTo/CityLocal/cityresponse.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styletext.dart';

class AdminLocationCity extends StatefulWidget {
  @override
  _AdminLocationCityState createState() => _AdminLocationCityState();
}



class _AdminLocationCityState extends State<AdminLocationCity> {

  String selectedCity;

  @override
  void initState() {
    super.initState();
    cityStream..getCity();
  }

  @override
  void dispose() {
    super.dispose();
    cityStream..drainStream();
  }

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
            border: Border.all(width: 1, color: wheretoDark ),
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
                                color: wheretoDark,
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
                                        color: wheretoDark,
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                   dropdownColor: Colors.white,
                                   icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:wheretoDark,
                                  ),
                                
                             items: cl.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.cityName,
                                  style: TextStyle(
                                            color: wheretoDark,
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
                                
                                }else{
                                  print("Tacloban");
                                
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

  @override
  Widget build(BuildContext context) {
     return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
         backgroundColor: Colors.white,
         child: Stack(
           alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
             Positioned(
              top: -50,
              child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: Icon(
                  Icons.location_city,
                  color: wheretoDark,
                  size: 30,
                ),
              ),
            )),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       SizedBox(height: 20,),
                      Text("You Can Change City Anytime",
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 18
                  ),
                  ),
                  SizedBox(height: 16,),
                  getCity(),
                  SizedBox(height: 15,),
                     Container(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text("Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gilroy-light"
                        ),
                        ),
                      ),
                      splashColor: pureblue,
                      color: wheretoDark,
                      onPressed: ()=>navigatepage()),
                  ),
                    ],
                  ),
                ),
                ),
            ),

          ],
         ),
      ),      
    );
  }

  void navigatepage(){
    if(selectedCity == null){
       showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice :",
        message: "Mr. Admin Please Select A City.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }else{
      UserGetPref().chosenCityAdmin(selectedCity.toString());
      Navigator.pop(context);
    }
  }

}
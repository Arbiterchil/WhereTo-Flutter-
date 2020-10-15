import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:WhereTo/Admin/trialSearch/Adminsearch.dart';
import 'package:WhereTo/CityLocal/cityStream.dart';
import 'package:WhereTo/CityLocal/cityclass.dart';
import 'package:WhereTo/CityLocal/cityresponse.dart';
import 'package:WhereTo/styletext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class EnterChoseFirst extends StatefulWidget {
  @override
  _EnterChoseFirstState createState() => _EnterChoseFirstState();
}

class _EnterChoseFirstState extends State<EnterChoseFirst> {
  
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
  
  String choseFrom;

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

Widget barangay(){
    return StreamBuilder<CityResponses>(
      stream: cityStream.subject.stream,
      builder: (context,AsyncSnapshot<CityResponses> snaphot){
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
      
      });
  }
  
  Widget _view(CityResponses respone){
    List<CityLocals> bararangs = respone.citys;
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
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
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
                              padding: const EdgeInsets.only(top:0.0),
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
                                  child: Text(e.cityName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value: choseFrom,
                               
                             onChanged: (val){
                               setState(() {
                                 choseFrom =val;
                               });
                             },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context,
                                new MaterialPageRoute(builder: (context) => AdminDash())
                                );
                              },
                              child: Icon(EvaIcons.closeCircle,
                              size: 50,
                              color: wheretoDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100,),
                  barangay(),
                  SizedBox(height: 15,),
                  Container(
                    height: 55,
                    width: 120,
                    child: RaisedButton(
                      splashColor: wheretoDark,
                      color: pureblue,
                      child: Center(
                        child: Text("Enter Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy-light'
                        ),
                        ),
                      ),
                      onPressed: (){
                        showSearch(context: context, 
                        delegate: AdminSearch(choseFrom));
                      }),
                  )
                ],
              ),
            ),
          )), 
      onWillPop: () async => false),
    );
  }
}
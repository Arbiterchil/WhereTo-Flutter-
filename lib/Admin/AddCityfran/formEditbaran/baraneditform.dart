
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/baranClass.dart';
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/changeC.dart';
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/formAp.dart';
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/formbaraneditbloc.dart';
import 'package:flutter/material.dart';

import '../../../styletext.dart';
import '../../admin_dash.dart';

class BaranggaySearchChrage extends StatefulWidget {
  @override
  _BaranggaySearchChrageState createState() => _BaranggaySearchChrageState();
}

class _BaranggaySearchChrageState extends State<BaranggaySearchChrage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 90,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: RaisedButton(
                          splashColor: Colors.white,
                          color: wheretoDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70)
                          ),
                          child: Center(
                            child: Text("X",
                            style: TextStyle(
                              fontFamily: "Gilroy-ExtraBold",
                              fontSize: 20,
                              color: Colors.white
                            ),
                            ),
                          ),
                          onPressed: ()=> Navigator.pushReplacement(
                            context,  PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 1),
                                  transitionsBuilder: (context,animation,animationtime,child){
                                    animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.elasticInOut,
                                    );
                                    return ScaleTransition(
                                      alignment: Alignment.topLeft,
                                      scale: animation,
                                      child: child,
                                      );
                                  },
                                  pageBuilder: (context,animation,animationtime){
                                    return AdminDash(); 
                                  }),),),
                      ),
                      SizedBox(width: 8,),
                      search(baranbloc),
             SizedBox(width: 8,),
              Container(
                        height: 50,
                        width: 50,
                        child: RaisedButton(
                          splashColor: Colors.white,
                          color: wheretoDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70)
                          ),
                          child: Center(
                            child: Icon(Icons.search,
                            size: 25,
                            color: Colors.white,
                            ),
                          ),
                          onPressed: ()=> searchData(baranbloc))
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                height: 500,
                child: StreamBuilder<List<BaranClass>>(
                  stream: searTbaran.barans,
                  builder: (context,snaps){
                     if(snaps.hasData){
                      if(snaps.data.length > 0){
                        return ListView.builder(
                          itemCount: snaps.data.length,
                          itemBuilder: (cont,ind){
                            return Padding(padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () => showDialog(context: (context),
                  barrierDismissible: true,
                  builder: (_) => ChangeChargebaran(id: snaps.data[ind].id,),),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                   color: Colors.white,
                                    borderRadius: BorderRadius.circular(140),
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
                                     alignment: Alignment.centerLeft,
                                     child: Padding(padding: const EdgeInsets.only(left: 20),
                                     child: Text(snaps.data[ind].barangayName,
                                     overflow: TextOverflow.ellipsis,
                                     style: TextStyle(
                                       color: wheretoDark,
                                       fontFamily: 'Gilroy-light',
                                       fontSize: 18
                                     ),
                                     ),
                                     ),
                                   ),
                                   Align(
                                     alignment: Alignment.centerRight,
                                     child: Padding(padding: const EdgeInsets.only(right: 20),
                                     child: Text(snaps.data[ind].charge.toString(),
                                     style: TextStyle(
                                       color: wheretoDark,
                                       fontFamily: 'Gilroy-ExtraBold',
                                       fontSize: 18
                                     ),
                                     ),
                                     ),
                                   ),
                                 ],
                               ),
                              ),
                            ),
                            );
                          });
                      }else{
              return Center(
              child: Image.asset("asset/img/nosearch.png")
              );
              }
                    }else{
                       return Center(
              child: Image.asset("asset/img/nosearch.png")
              );
                    }
                },),
                ), 
                ),
            ],
          ),
        )),
    );
  }

  searchData(BaranBloc baranBloc){
    baranBloc.searchforBaran();
  }

  Widget search(BaranBloc baranBloc){
     return  Expanded(
                       child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: StreamBuilder(
                stream: baranbloc.bararangSaika, 
                builder: (context,snaps){
                   return TextField(
          autocorrect: true,
                keyboardType: TextInputType.text,
                cursorColor: wheretoDark,
                obscureText: false,
                onChanged: baranBloc.changeSaika,
                style: TextStyle(
                  
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  
                ),
          decoration: InputDecoration(
             prefixIcon: Icon(
                    Icons.location_city,
                    color: wheretoDark,
                  ),
                  hintText: "Baranggay",
                  hintStyle: TextStyle(
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  ),
            errorText: snaps.error,
            labelText: "Search Baranggay",
            fillColor: wheretoDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide()
            ),
          ),
        );
                }),
            ),);
  }
}
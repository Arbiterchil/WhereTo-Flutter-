import 'package:WhereTo/Admin/AddCityfran/cityAp.dart';
import 'package:WhereTo/Admin/AddCityfran/cityframe.dart';
import 'package:WhereTo/Admin/AddCityfran/citysBloc.dart';
import 'package:WhereTo/Admin/AddCityfran/form/addcity.dart';
import 'package:WhereTo/Admin/AddCityfran/formbarangay/formaddbarangay.dart';
import 'package:WhereTo/CityLocal/cityclass.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';
import '../admin_dash.dart';

class SeacrhFormCitywithAdd extends StatefulWidget {
  @override
  _SeacrhFormCitywithAddState createState() => _SeacrhFormCitywithAddState();
}

class _SeacrhFormCitywithAddState extends State<SeacrhFormCitywithAdd> {
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
                     search(filtBloc),
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
                          onPressed: ()=> searchData(filtBloc))
                      ),
                    ],
                  ),
                )
              ),

              SizedBox(height: 15,),
              Padding(padding: const EdgeInsets.only(left: 60,right:60),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  splashColor: Colors.white,
                  color: wheretoDark,
                  child: Center(
                    child: Text("Add City",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Gilroy-light'
                    ),),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  onPressed: ()=> 
                  showDialog(context: (context),
                  barrierDismissible: true,
                  builder: (_) => FormAddCity(),
                  ))
              ),
              ),
              SizedBox(height: 25,),
              Padding(padding: const EdgeInsets.only(left: 25,right: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: StreamBuilder<List<CityAdmin>>(
                  stream: filtcity.sinkthem,
                  builder: (context,snaps){
                    if(snaps.hasData){
                      if(snaps.data.length > 0){
                        return ListView.builder(
                          itemCount: snaps.data.length,
                          itemBuilder: (cont,ind){
                            return Padding(padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () => Navigator.pushReplacement(context, 
                              MaterialPageRoute(builder: (_)=> 
                              FormAddbararang(
                                id: snaps.data[ind].id,
                                cityname: snaps.data[ind].cityName,
                                ))),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                   color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
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
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_city,
                                      size: 40,
                                      color: wheretoDark,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(snaps.data[ind].cityName,
                                      style: TextStyle(
                                        color: wheretoDark,
                                        fontSize: 20,
                                        fontFamily: 'Gilroy-ExtraBold'
                                      ),
                                      ),

                                    ],
                                  ),
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
                  },
                ),
              ),
              )
            ],
          ),
        )),
    );
  }
  
  searchData(CitySbloc citys){
     citys.searchIt();
  }


  Widget search(CitySbloc tities){
    return  Expanded(
                       child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: StreamBuilder(
                stream: tities.getsearch, 
                builder: (context,snaps){
                   return TextField(
          autocorrect: true,
                keyboardType: TextInputType.text,
                cursorColor: wheretoDark,
                obscureText: false,
                onChanged: tities.changeSearch,
                style: TextStyle(
                  
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  
                ),
          decoration: InputDecoration(
             prefixIcon: Icon(
                    Icons.location_city,
                    color: wheretoDark,
                  ),
                  hintText: "City",
                  hintStyle: TextStyle(
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  ),
            errorText: snaps.error,
            labelText: "Search City",
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
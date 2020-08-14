import 'dart:convert';

import 'package:WhereTo/Admin/admin_trial.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/editProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

class AddmenuAdmin extends StatefulWidget {
  @override
  _AddmenuAdminState createState() => _AddmenuAdminState();
}

class _AddmenuAdminState extends State<AddmenuAdmin> {

    var formkey = GlobalKey<FormState>();
    TextEditingController menuname  = TextEditingController();
    TextEditingController decription = TextEditingController();
    TextEditingController price = TextEditingController();
    int countname = 0;
    SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
  }
  int count = 1;
  @override
  Widget build(BuildContext context) {

     List<Widget> _categ = new List.generate(count, (index) => new TrialCardPratice()); 

    return Scaffold(
      body: WillPopScope(
        child: Container(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
                      gradient: LinearGradient(
                              stops: [0.1,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                         padding: EdgeInsets.symmetric(
                         horizontal: 40.0,
                         vertical: 80.0,
                       ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white
                    )
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Center(
                        child: Icon(Icons.add,
                        size: 30,
                        color: Color(0xFF0C375B),
                        ),
                      ),
                    ),
                  ),
                ),
               ), 
                              _menuForm(),
                              SizedBox(height: 20.0,),
                              addMinus(),
                              SizedBox(height: 10.0,),
                 Container(
                  height: 200,
                  child: new ListView(
                    scrollDirection: Axis.vertical,
                    children: _categ,
                  ),
                ),

                SizedBox(height: 25,),
                          ],
                        ) ,
                      )),
        ),
       onWillPop: () async => false),
    );
  }

  Widget _menuForm(){

    return Form(
      key: formkey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                SizedBox(height: 10.0,),
                     Text('Menu Name',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: menuname,
                validator: (val) => val.isEmpty ? ' Please Put Your Menu Name' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  hintText: 'Menu Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text('Description',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white,
                controller: decription,
                validator: (val) => val.isEmpty ? ' Please Put Your Description on this.' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  hintText: 'Description',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
                 Text('Price',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: Colors.white,
              keyboardType: TextInputType.number,
                controller: price,
                validator: (val) => val.isEmpty ? ' Please Put Your Price' : null,
                    onSaved: (val) => price.text = val,
                    
                
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  hintText: '0.00',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
                  ],
        ),
      ),

    );

  }

  Widget addMinus(){
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
         GestureDetector(
                   onTap: () async {
                      setState(() {
                        count = count + 1; 
                        
                      });
                   },
                   child: Container(
                     height: 40,
                     width: 90,
                     decoration: BoxDecoration(
                      //  border: Border.all(
                      //   width: 1,
                      //   color: Colors.white
                      // )
                     ),
                     child: Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        child: Center(
                          child: Icon(Icons.add,
                          size: 20,
                          color: Color(0xFF0C375B),
                          ),
                        ),
                      ),
                     ),
                   ),
                 ),

                  GestureDetector(
                   onTap: (){
                      setState(() {
                        count = count - 1;
                        
                      });
                   },
                   child: Container(
                     height: 40,
                     width: 90,
                     decoration: BoxDecoration(
                      //  border: Border.all(
                      //   width: 1,
                      //   color: Colors.white
                      // )
                     ),
                     child: Center(
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        child: Center(
                          child: Icon(Icons.flip_to_back,
                          size: 20,
                          color: Color(0xFF0C375B),
                          ),
                        ),
                      ),
                     ),
                   ),
                 ),                          
      ],
    );

  }

}
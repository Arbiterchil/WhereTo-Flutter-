import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

class TrialCardPratice extends StatefulWidget {
  @override
  _TrialCardPraticeState createState() => _TrialCardPraticeState();
}

class _TrialCardPraticeState extends State<TrialCardPratice> {


  List dataCategory = List();
  callCategory() async{

    var respon = await ApiCall().getCategory('/getCategories');
    var bararang = json.decode(respon.body);
  
    setState(() {
      dataCategory = bararang;
    });
    print(bararang);
  }
 
  int count = 1;
  String slectCategory;
  @override
  void initState() {
    super.initState();
    this.callCategory();
    slectCategory= null;
  }

  @override
  Widget build(BuildContext context) {
       return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Category",
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.category,
                            color: Colors.white,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Category",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor:  Color(0xFF0C375B),
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  
                                  value: slectCategory,

                                  items: dataCategory.map((item) {

                                  return new DropdownMenuItem(
                                   
                                    child: Text(item['categoryName'],
                                    style: TextStyle(
                                      
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                      slectCategory = item;
                                       print(item);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),
            SizedBox(height: 15.0,),
      ],
    );
  }
}
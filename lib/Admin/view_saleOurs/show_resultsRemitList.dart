import 'dart:convert';

import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:WhereTo/Admin/view_saleOurs/remit_listDate.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import '../../styletext.dart';
import 'package:intl/intl.dart';
class ShowemitListResult extends StatefulWidget {
  @override
  _ShowemitListResultState createState() => _ShowemitListResultState();
}

class _ShowemitListResultState extends State<ShowemitListResult> {

   DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  bool pressed = false;
  String dateFrom;
  String dateTo;
  String start;
  String end;
  var long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_) => AdminDash())),
                          child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: pureblue,
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            child: Center(
                              child: Text("Back <",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16
                              ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                     SizedBox(height: 30,),
                     Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                  border: Border.all(width: 1,color: pureblue),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: ()async {
                        final List<DateTime> pick = await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate:  startDate,
                        initialLastDate: endDate,
                        firstDate: new DateTime(DateTime.now().year -50),
                        lastDate: new DateTime(DateTime.now().year +50));
                        if(pick !=null && pick.length ==2){
                        
                          setState((){
                          print(pick);
                          startDate = pick[0];
                          endDate = pick[1];
                          start =DateFormat('yyyy-MM-dd').format(pick[0]).toString();
                          end =DateFormat('yyyy-MM-dd').format(pick[1]).toString();
                        });
                        var data = 
                        {
                            "dateFrom": start,
                            "dateTo": end
                        };
                        var restotal = await ApiCall().getTotalRestaurantSalesReport(data,'/getTotalSalesCommission');
                        var body = json.decode(restotal.body);
                        print(body);
                        setState(() {
                          long = body[0]["SUM(amount)"].toString();
                        });
                        }
                        

                        },
                        hoverColor: Colors.amber,
                        splashColor: pureblue,
                        child: Icon(
                          Icons.calendar_today,
                          color: pureblue,
                          size: 20,
                        ),
                      ),

                      Text(DateFormat('yyyy-MM-dd').format(startDate).toString() == null ?
                          "Starting Date" : 
                          DateFormat('yyyy-MM-dd').format(startDate).toString(),
                           style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-light'
                        )
                          ),

                          Icon(
                          Icons.arrow_right,
                          color: pureblue,
                          size: 40,
                        ),
                        
                         Text( DateFormat('yyyy-MM-dd').format(endDate).toString() == null ?
                           "Ending Date" :
                             DateFormat('yyyy-MM-dd').format(endDate).toString(),
                           style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-light'
                        )
                          ),
                    ],
                  ),
                ),

                SizedBox(height: 40,),

                  InkWell(
                   hoverColor: Colors.amber,
                        splashColor: pureblue,
                        onTap: (){
                          setState(() {
                            pressed = true;
                            dateTo = DateFormat('yyyy-MM-dd').format(endDate).toString();
                            dateFrom =DateFormat('yyyy-MM-dd').format(startDate).toString();
                            print(dateFrom+","+dateTo);
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: pureblue
                            ),
                          ),
                          child: Center(
                            child: Text("Show Result",
                            style: TextStyle(
                              color: pureblue,
                              fontFamily: 'Gilroy-light'
                            ),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 40,),
                pressed ? RemitListByDateWithTotal(
                  dateFrom: dateFrom.toString(),
                  dateTo:  dateTo.toString(),
                  lastresort : long
                ) : Text("Nothing to Show"),
                ],
              ),
            ),
          ) 
          ),
      onWillPop: () async=>false ),
    );
  }
}
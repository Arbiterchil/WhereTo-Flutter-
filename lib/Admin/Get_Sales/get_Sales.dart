import 'dart:convert';

import 'package:WhereTo/Admin/Get_Sales/get_salesStream.dart';
import 'package:WhereTo/Admin/Get_Sales/show_result.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:syncfusion_flutter_core/core.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'dart:async';

import '../../styletext.dart';
class GetSalesRepotgenerate extends StatefulWidget {

  final int restaurandId;

  const GetSalesRepotgenerate({Key key, @required this.restaurandId}) : super(key: key);

  @override
  _GetSalesRepotgenerateState createState() => _GetSalesRepotgenerateState(restaurandId);
}


class _GetSalesRepotgenerateState extends State<GetSalesRepotgenerate> {

  final int restaurandId;
  _GetSalesRepotgenerateState(this.restaurandId);

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  bool pressed = false;
  String dateFrom;
  String dateTo;
  @override
  void initState() {
 
    super.initState();
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(child: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                        
                          setState(() {
                          print(pick);
                          startDate = pick[0];
                          endDate = pick[1];
                          print(startDate);
                          print(endDate);
                          });
                        
                        }},
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
                          print( DateFormat('yyyy-MM-dd').format(startDate).toString()
                           +"-"+
                           DateFormat('yyyy-MM-dd').format(endDate).toString()
                           +"-"+
                           restaurandId.toString());
                          setState(() {
                            pressed = true;
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
                pressed ? ShowtheResults(
                  id: restaurandId,
                  dateFrom:  DateFormat("yyyy-MM-dd").format(startDate).toString(),
                  dateTo: DateFormat("yyyy-MM-dd").format(endDate).toString(),
                ) : Text("Nothing to Show"),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false),
      
    );
  }

  

}
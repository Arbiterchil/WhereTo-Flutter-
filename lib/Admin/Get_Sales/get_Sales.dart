import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:syncfusion_flutter_core/core.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'dart:async';
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
            padding: const EdgeInsets.all(20.0),
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
                SizedBox(height: 40,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Starting Date: ",
                        style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-ExtraBold'
                        )
                      ),
                      TextSpan(
                         text: 
                         DateFormat('yyyy-MM-dd').format(startDate).toString() == null ?
                          "NONE" : 
                          DateFormat('yyyy-MM-dd').format(startDate).toString(),
                        style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-light'
                        )
                      ),
                    ]
                  )),
                   SizedBox(height: 15,),
                   RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Ending Date: ",
                        style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-ExtraBold'
                        )
                      ),
                      TextSpan(
                         text: 
                          DateFormat('yyyy-MM-dd').format(endDate).toString() == null ?
                           "NONE" :
                             DateFormat('yyyy-MM-dd').format(endDate).toString(),
                        style: TextStyle(
                          color: pureblue,
                          fontSize: 18,
                          fontFamily: 'Gilroy-light'
                        )
                      ),
                    ]
                  )),
                  SizedBox(height: 25,),
                  RaisedButton(
                    color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () async {
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
        });
      
      }
                    },
                    child: Text ( "Select Date", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),
                    ),
                // dateWidget(),

                
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false),
      
    );
  }

  

}
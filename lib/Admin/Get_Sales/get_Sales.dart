import 'package:flutter/material.dart';

class GetSalesRepotgenerate extends StatefulWidget {

  final int restaurandId;

  const GetSalesRepotgenerate({Key key, @required this.restaurandId}) : super(key: key);

  @override
  _GetSalesRepotgenerateState createState() => _GetSalesRepotgenerateState(restaurandId);
}


class _GetSalesRepotgenerateState extends State<GetSalesRepotgenerate> {

  final int restaurandId;
  _GetSalesRepotgenerateState(this.restaurandId);

  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
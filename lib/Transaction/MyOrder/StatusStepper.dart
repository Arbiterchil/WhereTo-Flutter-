import 'package:flutter/material.dart';


class StepperStatus extends StatefulWidget {
  @override
  _StepperStatusState createState() => _StepperStatusState();
}

class _StepperStatusState extends State<StepperStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Order Tracker", style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
         
        ],
      ),
    );
  }
}
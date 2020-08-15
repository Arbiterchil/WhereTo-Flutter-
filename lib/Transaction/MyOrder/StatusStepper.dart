
import 'package:flutter/material.dart';

class StepperStatus extends StatefulWidget {
  final String status;
  StepperStatus({@required this.status});
  @override
  _StepperStatusState createState() => _StepperStatusState();
}

class _StepperStatusState extends State<StepperStatus> {
  int currStep;
  

  @override
  void initState() {
    currStep =2;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10),
                      child: GestureDetector(
                            onTap: ()=> Navigator.pop(context),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF0C375B),
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top:25.0),
                      child: Text("Order Tracker",
                      style: TextStyle(
                              color: Color(0xFF0C375B),
                              fontSize: 25.0,
                              fontFamily: 'Gilroy-light'
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:120.0),
              child: Center(
                child:Stepper(
              
              steps: [
                 Step(
                  state: StepState.complete,
                  title: Text(
                    "First Stage",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Color(0xFF0C375B),
                      letterSpacing: 2,
                      ),
                  ),
                  isActive: true,
                  content:widget.status.contains("2") ? Text("") : widget.status.contains("3") ? Text("") :widget.status.contains("0") ? Text("") : widget.status.contains("1") ?Text(
                    "The Rider is buying your order ",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Color(0xFF0C375B),
                      letterSpacing: 2,
                      fontFamily: 'Gilroy-ExtraBold'
                      ),
                  ):Text(""),
                ),
                Step(
                  state: StepState.complete,
                  isActive: true,
                  title: Text(
                    "Second Stage",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Color(0xFF0C375B),
                      letterSpacing: 2,
                      ),
                  ),
                  content: Center(
                    child: widget.status =="1" ? Text("") : widget.status =="3" ? Text("") :widget.status =="0" ? Text("") :widget.status =="2" ?Text(
                    "The Rider are on it's way to deliver",
                    style: TextStyle(
                      fontSize: 18, 
                      color: Color(0xFF0C375B),
                      letterSpacing: 2,
                      fontFamily: 'Gilroy-ExtraBold'
                      ),
                    ):Text(""), 
                  ),
                ),
                Step(
                  isActive: true,
                  state: StepState.complete,
                  title: Text(
                    "Third Stage",
                    style: TextStyle(
                      fontSize: 18, 
                      color:Color(0xFF0C375B),
                      letterSpacing: 2,
                      ),
                  ),
                  content: Center(
                    child: widget.status =="1" ? Text("") : widget.status =="2" ? Text("") :widget.status =="0" ? Text("") :widget.status =="3" ? Text(
                    "The Rider delivered your order",
                    style: TextStyle(
                      fontSize: 18, 
                      
                      color: Color(0xFF0C375B),
                      letterSpacing: 2,
                      fontFamily: 'Gilroy-ExtraBold'
                      ),
                  ):Text(""),
                  )
                ),
              ],
              currentStep: currStep,
              controlsBuilder:(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Center(
                  child: Container(),
                );
          },
          ) ,
              ),
            )
          ],
        ),),
     
     
    );
  }

 


 
}

import 'package:WhereTo/designbuttons.dart';
import 'package:flutter/material.dart';

class StepperStatus extends StatefulWidget {
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
      backgroundColor: Color(0xFF398AE5),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        leading: DesignButton(
          height: 55,
          width: 55,
          color: Color(0xFF398AE5),
          offblackBlue: Offset(-4, -4),
          offsetBlue: Offset(4, 4),
          blurlevel: 4.0,
          icon: Icons.arrow_back,
          iconSize: 30.0,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "My Order Tracker",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stepper(
            
            steps: steps,
            currentStep: currStep,
            controlsBuilder:(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Center(
                child: Container(),
              );
          },
          ),
        ],
      ),
    );
  }

  List<Step> steps = <Step>[
    Step(
      state: StepState.complete,
      title: Text(
        "First Stage",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
      content: Text(
        "The Rider is buying your order ",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
    ),
    Step(
      state: StepState.complete,
      title: Text(
        "Second Stage",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
      content: Center(
        child: Text(
        "The Rider are on it's way to deliver",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
      )
    ),
    Step(
      state: StepState.complete,
      title: Text(
        "Third Stage",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
      content: Center(
        child: Text(
        "The Rider delivered your order",
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white,
          letterSpacing: 2,
          ),
      ),
      )
    ),
  ];
}

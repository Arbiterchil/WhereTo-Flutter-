import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ETry/saerchTry.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/editpage.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/canceltransa.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/notifsending.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuView.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLastStepper extends StatefulWidget {

  final int getId;
  final String restuName;
  final String deviceId;
  final String address;
  final String name;
  final String contact;

  const ViewLastStepper({Key key, this.getId, this.restuName, this.deviceId, this.address, this.name, this.contact}) : super(key: key);
  
  

  @override
  _ViewLastStepperState createState() => _ViewLastStepperState(getId,restuName,deviceId,address,name,contact);
}

class _ViewLastStepperState extends State<ViewLastStepper> {

  final int getId;
  final String restuName;
  final String deviceId;
  final String address;
  final String name;
  final String contact;

 
    int currentStep = 0;
    var stepnumber;
    bool complete = false;




    List<Step> steps = [
      Step(
        title: const Text("Buy",
        style: TextStyle(
          fontFamily: 'OpenSans',
          color:  Colors.black,
        ),
        ),
        isActive: true,
        state: StepState.editing,
        content: MenuViewNew(),),


         Step(
        title: const Text("Deliver",
        style: TextStyle(
          fontFamily: 'OpenSans',
          color:  Colors.black,
        ),
        ),
        isActive: true,
        state: StepState.complete,
        
        content: Stack(
         children: <Widget>[
           Align(
             alignment: Alignment.topCenter,
             child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("asset/img/deliveryProcess.png"))
                          // color: Color(0xFF0C375B),
                        ),
                        // child: Text("2"),
                ),
           ),
         ], 
        )),
         Step(
        title: const Text("Done.",
        style: TextStyle(
          fontFamily: 'OpenSans',
          color:  Colors.black,
        ),
        ),
        isActive: true,
        state: StepState.complete,
        content: Stack(
          alignment: Alignment.topCenter,
         children: <Widget>[
           Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("asset/img/doneprocess.png"))
                        // color: Color(0xFF0C375B),
                      ),
                      // child: Text("2"),
              ),
         ], 
        ))

  ];

  _ViewLastStepperState(this.getId, this.restuName, this.deviceId, this.address, this.name, this.contact);

  

  nextSteps(){
    currentStep + 1 != steps.length
    ? goTo(currentStep + 1) 
    : setState(()=> complete = true);
   
    stepnumber = currentStep+ 1;  
  }



  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }
  goTo(int step){
    setState(() => currentStep = step);
    print(step);
      if(step == 1){
      deliver();
    }else if(step == 2){
      done();
    }
  }

    deliver() async {
  await ApiCall().transactionDelivery('/transactionDelivery/$getId');
  notifyingSend..notifySend(deviceId, "HI.! im Your Rider and im Delivering the Order you Made and Have a Nice Day.");
  }
  done() async{
  notifyingSend..notifySend(deviceId, "The Order you Made is Successfully Delivered.");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  containingData(),
                  SizedBox(height: 35,),
                  complete ?
                   Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                     gradient: LinearGradient(
                                  stops: [0.2,4],
                                  colors: 
                                  [
                                    Color(0xFF0C375B),
                                    Color(0xFF176DB5)
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20),
                                        child: Text("Done! Orders Successfully Delivered.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                        ),),
                                      ),
                                      SizedBox(height: 30.0,),
                                      Text("Again Job Well Done!.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                      SizedBox(height: 10.0,),
                                       RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                      onPressed: () async {
                                        await ApiCall().transactionComplete('/transactionComplete/$getId');
                                        SharedPreferences localStorage = await SharedPreferences.getInstance();
                                        localStorage.remove('menuplustrans');
                                         localStorage.remove('restauranId');
                                        // localStorage.remove('playerIDS');
                                         Navigator.pushReplacement(context, 
                                                   new MaterialPageRoute(builder: (context) =>
                                                   RiderProfile())
                                                   );
                                            //   setState(() {
                                            //   complete = false;                    

                                            // });
                                      // Navigator.of(context).pop();
                                          },   
                                      child: Text ( "Yes", style :TextStyle(
                                      color: Color(0xFF398AE5),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.0,
                                                  fontFamily: 'OpenSans'
                                    ),),),
                                    ],
                                  ),
                                ),
                              ),
                            ):                         
                          Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 600,
                                  child: Stepper(
                                      steps: steps,
                                      type: StepperType.horizontal,
                                      currentStep: currentStep,
                                      onStepContinue: nextSteps,
                                      onStepTapped: (step) => goTo(step),
                                      onStepCancel: cancel,
                                      controlsBuilder: (
                                        BuildContext context ,{VoidCallback onStepContinue,VoidCallback onStepCancel}){
                                           return SingleChildScrollView(
                                             scrollDirection: Axis.horizontal,
                                             child: Container(
                                               height: 55,
                                              width: MediaQuery.of(context).size.width,
                                               child: Row(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: <Widget>[

                                                   Container(
                                                     height: 50,
                                                     width: 100,
                                                     child: RaisedButton(
                                                       shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(90)
                                                       ),
                                                       splashColor: Colors.white,
                                                       color: wheretoDark,
                                                       child: Center(
                                                         child: Text('OK',
                                                         style: TextStyle(
                                                           color: Colors.white,
                                                           fontFamily: 'Gilroy-light',
                                                           fontSize: 12
                                                         ),
                                                         ),
                                                       ),
                                                       onPressed: onStepContinue),
                                                   ),
                                                     SizedBox(width: 15.0,),
                                                    Container(
                                                     height: 50,
                                                     width: 100,
                                                     child: RaisedButton(
                                                       shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(90)
                                                       ),
                                                       splashColor: Colors.white,
                                                       color: wheretoDark,
                                                       child: Center(
                                                         child: Text('Back',
                                                         style: TextStyle(
                                                           color: Colors.white,
                                                           fontFamily: 'Gilroy-light',
                                                           fontSize: 12
                                                         ),
                                                         ),
                                                       ),
                                                       onPressed: onStepCancel),
                                                   ),

                                                  

                                                 ],
                                               ),
                                             ),
                                           ); 
                                      },
                                  ),
                                ),
                ],
              ),
           
          )),
      onWillPop: () async => false),
    );
  }

  Widget containingData(){
    return Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight:Radius.circular(15),
                  )
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [

                    Align(
                      alignment: Alignment.topRight,
                      child:   Padding(
                  padding: const EdgeInsets.only(top: 15,right: 20),
                    child: Container(
                      height: 50,
                      width: 140,
                      child: RaisedButton(
                        splashColor: Colors.white,
                        color: wheretoDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: Text('Cancel Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy-light',
                            fontSize: 12
                          ),
                          ),
                        ),
                        onPressed: ()=> showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPumpingHeart(color: wheretoDark,size: 80,),
        labelHeader: "Are You Sure want to Cancel This?",
        message: "If you do you will Notify the Customer.",
        buttTitle1: "YES",
        buttTitle2: "NO",
        noFunc: ()=>Navigator.pop(context),
        yesFunc: () => demonDay..cancelOrder(
        context,
        getId,
        "The Order You Made is Cancelled Due to Maybe the Restaurant is Close or Due to Other Circumstances",
        deviceId),
        showorNot1: true,
        showorNot2: true,
      ),)
                        
                        ),
                    ),
                  ),
                  ),

                      Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,bottom: 50),
                                    child: Container(
                                      height: 28,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 4,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: wheretoDark,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          SizedBox(height: 4,),
                                           Container(
                                            height: 4,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: wheretoDark,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                      Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,top:10,bottom: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        //  Navigator.pushReplacement(context, 
                                        //  new MaterialPageRoute(builder: (_)=> EditPageMenuTrial())
                                        //  );
                                        //     Navigator.pushReplacement(context, 
                                        //  new MaterialPageRoute(builder: (_)=>SearchTrend())
                                        //  );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 45,
                                        color: wheretoDark,
                                      ),
                                    ),
                                    ),
                                ),
                      Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30,top: 25) ,
                                    child: Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-ExtraBold",
                                                  fontSize: 20                                      ),
                                                ),
                                                SizedBox(height: 5,),
                                                 Text(address,
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-light",
                                                  fontSize: 14                                      ),
                                                ),
                                                 SizedBox(height: 5,),
                                                 Text(restuName,
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-light",
                                                  fontSize: 14                                      ),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(contact,
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-light",
                                                  fontSize: 14                                      ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),


                  ],
                ),
    
      );
  }

}
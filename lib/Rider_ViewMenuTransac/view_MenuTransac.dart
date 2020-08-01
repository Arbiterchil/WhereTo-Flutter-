import 'dart:convert';
import 'package:WhereTo/AnCustom/dialog_showGlobal.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_headerpage.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/button_OkAssign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ridershowStep_Menu.dart';
import 'package:WhereTo/Rider_viewTransac/rider_viewtransac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMenuOnTransac extends StatefulWidget {
  
  final String getID;
  final String gotTotal;
  final String deliverTo;
  final String restaurantName;
  final String riderID;
  final String deviceID;
  final String deliveryCharge;
  final String nametran;

  const ViewMenuOnTransac({Key key, this.getID, this.gotTotal, this.deliverTo, this.restaurantName, this.riderID, this.deviceID, this.deliveryCharge, this.nametran}) : super(key: key);
 
 
  
  @override
  _ViewMenuOnTransacState createState() => _ViewMenuOnTransacState();
}



class _ViewMenuOnTransacState extends State<ViewMenuOnTransac> {


StepperType stepperType = StepperType.horizontal;

switchThis(){

  setState(() => stepperType == StepperType.horizontal 
  ? stepperType = StepperType.vertical
  : stepperType = StepperType.horizontal);

}

var totalAll;
var deliverFee;
var priceTotal = 0;
var quantityTotal = 0;
var totals;
var userData;
var stepnumber;
bool available = true;
bool okAvail = true;
int currentStep = 0;
bool complete = false;
bool stepTf = true;
bool menuHide = true;
bool backTF =true;

@override
  void initState() {
    _getUserInfo();
    
    super.initState();
    riderCheck();
  }

   Widget _viewMenus(){

        return Visibility(
          visible: menuHide,
          child: Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: getMenuTransac(),
              builder: (BuildContext context, AsyncSnapshot snapshot){


                if(snapshot.data == null){
                  return Container(
                        child: Center(
                          child: Text("Loading Menu's Please wait...",
                          style: TextStyle(
                  color:  Color(0xFF0C375B),
                  fontFamily: 'OpenSans',
                  fontSize:  16.0,
                  fontWeight: FontWeight.normal
                ),),    
                        ),
                      );
                }else{
                  
                    return Container(
                      
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){

                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                    children: <Widget>[
                                     
                                       MenuDesign(
                                         menuname: snapshot.data[index].menuName,
                                         description: snapshot.data[index].description,
                                         price: snapshot.data[index].price.toString(),
                                         quantity: snapshot.data[index].quantity.toString(),

                                       ),
                                       
                                    ],

                                ),
                              );



                        }),
                    );
                }



              },
              ),
          ),
        );

    }


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
        content: MShowStep(),),
         Step(
        title: const Text("Deliver",
        style: TextStyle(
          fontFamily: 'OpenSans',
          color:  Colors.black,
        ),
        ),
        isActive: true,
        state: StepState.complete,
        
        content: Column(
         children: <Widget>[
           SizedBox(height: 15.0,),
           Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: eCBox,
                      child: Text("2"),
              ),
              SizedBox(height: 15.0,),
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
        content: Column(
         children: <Widget>[
           SizedBox(height: 15.0,),
           Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: eCBox,
                      child: Text("3"),
              ),
              SizedBox(height: 15.0,),
         ], 
        ))

  ];


  nextSteps(){
    currentStep + 1 != steps.length
    ? goTo(currentStep + 1) 
    : setState(()=> complete = true);
   
    stepnumber = currentStep+ 1;
    print(stepnumber);
  } 


  cancel(){
    if(currentStep > 0){
      goTo(currentStep - 1);
    }
  }
  goTo(int step){
    setState(() => currentStep = step);
  }
void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }

Future<List<RiverMenu>> getMenuTransac() async {


        final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${widget.getID}');
        // final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/3');
        
        List<RiverMenu> ridermenu = [];

        var body = json.decode(response.body);
        for(var body in body){
            RiverMenu riverMenu = RiverMenu(
              menuName: body["menuName"],
              description: body["description"],
              price: body["price"],
              quantity: body["quantity"],
            );
           
            ridermenu.add(riverMenu);          
        }

       

        return ridermenu;
        
  }

void riderCheck() async{
SharedPreferences localStorage = await SharedPreferences.getInstance();
var checkVal = localStorage.getBool('check');
        String riderId = widget.riderID.toString();
        if(riderId == "null"){
          print(riderId);
              setState(() {
                okAvail = !okAvail;
                available = available;
              });
        }else if(riderId != null){
          setState(() {
            available = !available;
            
            if(checkVal != null){
              if(checkVal){
                print(userData['id'].toString()+"-"+riderId);
                if(riderId != userData['id'].toString()){
                    okAvail = !okAvail;
                }else{
                  okAvail = okAvail;
                  menuHide = !menuHide;
                  backTF = !backTF;
                }
              }
               
            } 

          });
        }
        


        

    }


   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xFFF2F2F2),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Stack(
                      alignment: AlignmentDirectional.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[                      
                        Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                              
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),

                        ),
                       Padding(
                         padding: const EdgeInsets.only(top: 5,left: 30,right: 30),
                         child: Container(
                               height: 220.0,
                               child: Column(
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(top: 35.0),
                                     child: Row(
                                       children: <Widget>[
                                      Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white,
                                          //  Color(0xFF398AE5),
                                          width: 2.0,
                                        ),
                                        
                                        ),
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("asset/img/app.jpg"),
                                        ),
                                          ),
                                      SizedBox(width: 20.0,),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                          children: <Widget>[
                                                  Text("${widget.nametran}",
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text("Restaurant : ${widget.restaurantName}",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text("Deliver To : ${widget.deliverTo}",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                  
                                                  color: Colors.grey[300],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text("${widget.deliveryCharge}",
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                    
                                        


                                       ],
                                     ),
                                   ), 
                                   Padding(
                                      padding: const EdgeInsets.only(top: 15,left: 50,right: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Visibility(
                                            visible: backTF,
                                            child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                  return RiderTransaction();
                                                }));
                    },                
                    child: Text ( "BACK", style :TextStyle(
                    color: Color(0xFF0C375B),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'OpenSans'
                  ),),),
                                          ),
                   SizedBox(width: 30.0,),
                                           Visibility(
                                        visible: available,
                                        child: DesignButton(
                                          height: 55,
                                          width: 55,
                                          color: Color(0xFF398AE5),
                                          offblackBlue: Offset(-4, -4),
                                          offsetBlue: Offset(4, 4),
                                          blurlevel: 4.0,
                                          icon: Icons.motorcycle,
                                          iconSize: 30.0,
                                          onTap: (){
                                                xDilogAhow(context);
                                            print(userData['id']);
                                          },
                                        ),
                                      ),
                                         
                                          
                                        ],
                                      ),
                                     ), 
                                 ],
                               ),
                             ),
                       ),
                        Padding(padding: const EdgeInsets.only(top:210,left: 40,right: 40),
                        child: Container(
                         height: 50.0,
                         width: 120,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10.0),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
                           ],
                         ),
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child:  Text("₱ ${widget.gotTotal}",
                                              style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                              fontFamily: 'OpenSans'
                                            ),
                                              ),),
                            ],
                          ),
                        ),
                        )
                      ],
                    ),
          
                      SizedBox(height: 10.0,),
                        complete ? Center(
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
                                  Text("Done! Orders Successfully Delivered.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),),
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
                                  onPressed: () {
                                          setState(() {
                                          complete = false;                    
                                                              });
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
                        
                        Visibility(
                          visible: okAvail,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 450.0,
                              child: Stepper(
                                  steps: steps,
                                  type: stepperType,
                                  currentStep: currentStep,
                                  onStepContinue: nextSteps,
                                  onStepTapped: (step) => goTo(step),
                                  onStepCancel: cancel,
                                  controlsBuilder: (
                                    BuildContext context ,{VoidCallback onStepContinue,VoidCallback onStepCancel}){
                                       return Row(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                            NCard1Button(
                                          width: 100,
                                          icon: Icons.skip_next,
                                          label: "OK",
                                          onTap: onStepContinue,
                                          active: false,
                                            ),
                                            SizedBox(width: 30.0,),
                                            NCard1Button(
                                          width: 115,
                                          icon: Icons.cancel,
                                          label: "CANCEL",
                                          onTap: onStepCancel,
                                          active: true,
                                            ),

                                         ],
                                       ); 
                                  },
                              ),
                            ),
                          
                        ),
                        
                      SizedBox(height: 20.0,),
                    _viewMenus(),
                      ],
                    
                    ),
                    
                    ),
                    
                   
              ),
          ),
        ),
      );


  }

  void assign() async { 

      bool checkthis = true;

      var data = {
        "transactionId" : '${widget.getID}',
        "riderId" :  userData['id'],
      };

      var response = await ApiCall().assignRiders(data, '/assignRider');
      var body = json.decode(response.body);
      if(body == true){
        print("TRUE");
        SharedPreferences localStore = await SharedPreferences.getInstance();
        localStore.setBool("cuurentIdtrans", checkthis);
        localStore.setString("menuplustrans", "${widget.getID}");
      }else{
        print("FALSE");
      }


  }
  void xDilogAhow(context){
      showDialog(context: context,
      barrierDismissible: true,
      builder: (BuildContext context){

          return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustom(context),
    ); 


      });


  }
    mCustom(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Accept Transcation Orders?",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    fontFamily: 'OpenSans'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text ( "No", style :TextStyle(
                  color: Color(0xFF0C375B),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                SizedBox(width: 20.0,),
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                                                setState(() {
                                                available = !available;
                                                menuHide = !menuHide;
                                                backTF = !backTF;
                                                assign();
                                                riderCheck();
                                              });
                   Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      );


    }
}




class NCard extends StatelessWidget {
  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  const NCard({this.active,this.icon,this.onTap,this.label});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        decoration: BoxDecoration(
          color:  Color(0xFF0C375B)
        ),
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.white),
            SizedBox(width: 20.0,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  fontFamily: 'OpenSans'
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class NCard1Button extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  final double  width;

  const NCard1Button({Key key, this.active, this.icon, this.label, this.onTap, this.width}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 60.0,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        decoration: BoxDecoration(
          color:  Color(0xFF0C375B),
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.white),
            SizedBox(width: 3.0,),
               Text(label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  fontFamily: 'OpenSans'
                ),),
             
          ],
        ),
      ),
    );
  }
}

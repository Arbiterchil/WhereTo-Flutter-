import 'dart:convert';
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

  const ViewMenuOnTransac({Key key, this.getID, this.gotTotal, this.deliverTo, this.restaurantName, this.riderID, this.deviceID}) : super(key: key);

 
  
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
bool available = true;
bool okAvail = true;
int currentStep = 0;
bool complete = false;
bool stepTf = true;
bool menuHide = true;

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
                  color: Colors.white,
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
        content: Column(
         children: <Widget>[
              MShowStep(),
              SizedBox(height: 15.0,),
         ], 
        )),
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
                }
              }
               
            } 

          });
        }
        


        

    }


   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xFF398AE5),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                           Container(
                        width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: DesignButton(
                                        height: 55,
                                        width: 55,
                                        color: Color(0xFF398AE5),
                                        offblackBlue: Offset(-4, -4),
                                        offsetBlue: Offset(4, 4),
                                        blurlevel: 4.0,
                                        icon: Icons.arrow_back,
                                        iconSize: 30.0,
                                        onTap: ()  {
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                return RiderTransaction();
                                              }));
                                     
                                    },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Visibility(
                                        visible: available,
                                        child: DesignButton(
                                          height: 55,
                                          width: 55,
                                          color: Color(0xFF398AE5),
                                          offblackBlue: Offset(-4, -4),
                                          offsetBlue: Offset(4, 4),
                                          blurlevel: 4.0,
                                          icon: Icons.drive_eta,
                                          iconSize: 30.0,
                                          onTap: (){
                                            setState(() {
                                              available = !available;
                                              menuHide = !menuHide;
                                              assign();
                                              riderCheck();
                                            });
                                            
                                            print(userData['id']);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      SizedBox(height: 40.0,),
                
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
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: <Widget>[
                                            NCard1Button(
                                          width: 100,
                                          icon: Icons.skip_next,
                                          label: "OK",
                                          onTap: onStepContinue,
                                          active: false,
                                            ),
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
                        // Visibility(
                        //   // visible: okAvail,
                        //   child: Stepper(
                        //             steps: steps,
                        //             // type: stepperType,
                        //             currentStep: currentStep,
                        //             onStepContinue: nextSteps,
                        //             onStepTapped: (step) => goTo(step),
                        //             onStepCancel: cancel,
                        //             controlsBuilder: (
                        //               BuildContext context ,{VoidCallback onStepContinue,VoidCallback onStepCancel}){
                        //                  return Row(
                        //                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                    children: <Widget>[
                        //                       NCard1Button(
                        //                     width: 100,
                        //                     icon: Icons.skip_next,
                        //                     label: "OK",
                        //                     onTap: onStepContinue,
                        //                     active: false,
                        //                       ),
                        //                       NCard1Button(
                        //                     width: 115,
                        //                     icon: Icons.cancel,
                        //                     label: "CANCEL",
                        //                     onTap: onStepCancel,
                        //                     active: true,
                        //                       ),

                        //                    ],
                        //                  ); 
                        //             },
                        //         ),
                        // ),
                      SizedBox(height: 20.0,),
                    _viewMenus(),

                    SizedBox(height: 40.0,),
                   
                    NCard(
                    active: false,
                    icon: Icons.restaurant_menu,
                    label: "Restaurant : ${widget.restaurantName}",
                  ),
                   SizedBox(height: 20.0,),
                    NCard(
                    active: false,
                    icon: Icons.shopping_cart,
                    label: "Total : ${widget.gotTotal}",
                  ),
                  SizedBox(height: 20.0,),
                    NCard(
                    active: false,
                    icon: Icons.payment,
                    label: "Fee :"+deliverFee.toString(),
                  ),
                  SizedBox(height: 20.0,),
                    NCard(
                    active: false,
                    icon: Icons.location_city,
                    label: "Deliver To : ${widget.deliverTo}",
                  ),
                  SizedBox(height: 30.0,),
                      ],
                    
                    ),
                    
                    ),
                    
                    ),
              ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.swap_horizontal_circle),
        //   onPressed: switchThis,
        // ),
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
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        // return RiderTransaction();
        //   }));
      }else{
        print("FALSE");
      }


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
        decoration: eBox,
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
        decoration: eBox,
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

// class CallerMenu extends StatelessWidget{

  // final String getId;

  // const CallerMenu({Key key, this.getId}) : super(key: key);


  //  Future<List<RiverMenu>> getMenuTransaction() async {


  //       final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/3');
  //       List<RiverMenu> ridermenu = [];

  //       var body = json.decode(response.body);
  //       for(var body in body){
  //           RiverMenu riverMenu = RiverMenu(
  //             menuName: body["menuName"],
  //             description: body["description"],
  //             price: body["price"],
  //             quantity: body["quantity"],
  //           );
           
  //           ridermenu.add(riverMenu);          
  //       }

       

  //       return ridermenu;
        
  // }

   
  
  
  // @override
  // Widget build(BuildContext context) {
  //    return Container(
  //         height: 240,
  //         width: MediaQuery.of(context).size.width,
  //         child: FutureBuilder(
  //           future: getMenuTransaction(),
  //           builder: (BuildContext context, AsyncSnapshot snapshot){


  //             if(snapshot.data == null){
  //               return Container(
  //                     child: Center(
  //                       child: Text("Loading Menu's Please wait...",
  //                       style: TextStyle(
  //               color: Colors.white,
  //               fontFamily: 'OpenSans',
  //               fontSize:  16.0,
  //               fontWeight: FontWeight.normal
  //             ),),    
  //                     ),
  //                   );
  //             }else{
                
  //                 return Container(
                    
  //                   child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     itemCount: snapshot.data.length,
  //                     itemBuilder: (context,index){

  //                           return Padding(
  //                             padding: const EdgeInsets.all(15.0),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
  //                                 children: <Widget>[
                                   
  //                                    MenuDesign(
  //                                      menuname: snapshot.data[index].menuName,
  //                                      description: snapshot.data[index].description,
  //                                      price: snapshot.data[index].price.toString(),
  //                                      quantity: snapshot.data[index].quantity.toString(),

  //                                    ),
                                     
  //                                 ],

  //                             ),
  //                           );



  //                     }),
  //                 );
  //             }



  //           },
  //           ),
  //       );
  // }

// }
import 'dart:convert';
import 'package:WhereTo/AnCustom/Rider_havePendingtrans.dart';
import 'package:WhereTo/AnCustom/dialog_showGlobal.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_headerpage.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/button_OkAssign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:http/http.dart' as http;
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
  final String playerId;
  final String transacIDs;
  final String user_coor;
  final String contactNumber;

  const ViewMenuOnTransac({Key key, this.getID, this.gotTotal, this.deliverTo, this.restaurantName, this.riderID, this.deviceID, this.deliveryCharge, this.nametran, this.playerId, this.transacIDs, this.user_coor, this.contactNumber}) : super(key: key);

 
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
var idgetter;
var iderntify;
@override
  void initState() {
     identify();
    getTotalPrice();
    _getUserInfo();
    riderCheck();
    super.initState();
    
  }


  void identify() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userRider = localStorage.getString('menuplustrans');

      if(userRider != null){
        showDialog(context: context,
        barrierDismissible: false,
        builder: (context) => RiderPending(
          message: "You have Still a Pending Transaction.",
          function: () => Navigator.pop(context),
        )
        );
      }else{
        print("can get This transac.");
      }
  }



  notif2() async {
       String url = 'https://onesignal.com/api/v1/notifications';
    // var playerId = status.subscriptionStatus.userId;
    // var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
    // var numb = "3";
    var contents = {
      "include_player_ids": ['${widget.playerId}'],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "Your Order is Being Delivered."},

      "data": {
        "id": "${userData['id']}",
        "transact_id":"${widget.getID}",
        "status":"3"
      },
      "headings": {"en": "WhereTo Rider"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
    };
    var repo =
        await http.post(url, headers: headers, body: json.encode(contents));
        print(repo.body);
  }
  notif3() async {
 String url = 'https://onesignal.com/api/v1/notifications';
    // var playerId = status.subscriptionStatus.userId;
    // var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
    // var numb = "3";
    var contents = {
      "include_player_ids": ['${widget.playerId}'],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "Your Order Successfully Delivered."},

      "data": {
        "id": "${userData['id']}",
        "transact_id":"${widget.getID}",
        "status":"4"
      },
      "headings": {"en": "WhereTo Rider"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
    };
    var repo =
        await http.post(url, headers: headers, body: json.encode(contents));
        print(repo.body);
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

  // by() async {
  // await ApiCall().transactionBuying('/transactionBuying/${widget.getID}');
  // notif1();
  // }
  deliver() async {
  await ApiCall().transactionDelivery('/transactionDelivery/${widget.getID}');
  notif2();
  }
  done() async{
  await ApiCall().transactionComplete('/transactionComplete/${widget.getID}');
  notif3();
  }

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

void getTotalPrice() async{


final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${widget.getID.toString()}');                     
                              var body = json.decode(response.body);
                              for(var body in body){
                                  RiverMenu riverMenu = RiverMenu(
                                    menuName: body["menuName"],
                              description: body["description"],
                              price: body["price"],
                              quantity: body["quantity"],
                                  );
                                  List prices =  [riverMenu.price] ;
                                  List quans =  [riverMenu.quantity];
                                  for(var i = 0 ; i < prices.length; i++){
                                    for(var x = 0 ; x < quans.length ; x++){
                                        totalAll = prices[i]*quans[x];
                                      List all =  [totalAll]; 
                                      for(var z = 0 ; z < all.length; z++){
                                        
                                            priceTotal = priceTotal+all[z];
                                            
                              
                                            
                                      }
                                  }
                                  }           
                              }
                              setState(() {
                                  totals = priceTotal;
                              print(totals);

                              });
                            
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Column(
                        
                        children: <Widget>[
                      
                        SizedBox(height: 10,),
                        Container(
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: pureblue
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("asset/img/logo.png") )
                                ),
                              ),

                              Flexible(
                                child: Container(
                                  width: 120,
                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                      Text("${widget.nametran}",
                                                      style: TextStyle(
                                                      color:pureblue,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                      fontFamily: 'OpenSans'
                                                    ),
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Text("${widget.restaurantName}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                      color: pureblue.withOpacity(.80),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12.0,
                                                      fontFamily: 'OpenSans'
                                                    ),
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Text("${widget.contactNumber}",
                                                      style: TextStyle(
                                                      color:pureblue,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                      fontFamily: 'OpenSans'
                                                    ),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text("${widget.deliveryCharge}",
                                                      style: TextStyle(
                                                      color:pureblue,
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
                         SizedBox(height: 20 ,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                                        child: Container(
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                            // border: Border.all(
                                                            //   width: 1,
                                                            //   color: pureblue
                                                            // ),
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          ),
                                                          child: Text("${widget.deliverTo}",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                          
                                                          color: pureblue,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 22.0,
                                                          fontFamily: 'Gilroy-light'
                                                    ),
                                                          ),
                                                        ),
                                                      ),

                         SizedBox(height: 10,),
                         Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                                        Visibility(
                                              visible: backTF,
                                              child: 
                                              GestureDetector(
                                                onTap: (){
                                                  // Navigator.pop(context);
                                                 Navigator.pushReplacement(context, 
                                                 new MaterialPageRoute(builder: (context) =>
                                                 RiderTransaction())
                                                 );
                                                },
                                                child: Container(
                                                   height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: pureblue
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 30,
                                                  color: pureblue,
                                                ),
                                              ),
                                                ),
                                              )
                                            ),
                   SizedBox(width: 30.0,),
                    
                                             Visibility(
                                          visible: available,
                                          child: GestureDetector(
                                            onTap: (){
                                              xDilogAhow(context);
                                              print(userData['id']);
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: pureblue,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.motorcycle,
                                                  size: 30,
                                                  color: pureblue,
                                                ),
                                              ),
                                            ),


                                          ),
                                        ),

                            ],
                          ),
                        ),
                           
                           Container(
                           height: 50.0,
                           width: 120,
                           decoration: BoxDecoration(
                             border: Border.all(
                               width: 1,
                               color: pureblue
                             ),
                             borderRadius: BorderRadius.circular(10.0),
                           ),
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child:  Text(totals == null ? "..." : "₱ $totals",
                                                style: TextStyle(
                                                color: pureblue,
                                                fontSize: 25.0,
                                                fontFamily: 'Gilroy-ExtraBold'
                                              ),
                                                ),),
                              ],
                            ),
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
                                      SharedPreferences localStorage = await SharedPreferences.getInstance();
                                      localStorage.remove('menuplustrans');
                                      localStorage.remove('playerIDS');
                                       Navigator.pushReplacement(context, 
                                                 new MaterialPageRoute(builder: (context) =>
                                                 RiderTransaction())
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
                          Visibility(
                            visible: okAvail,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 450.0,
                                child: Stepper(
                                    steps: steps,
                                    // type: stepperType,
                                    currentStep: currentStep,
                                    onStepContinue: nextSteps,
                                    onStepTapped: (step) => goTo(step),
                                    onStepCancel: cancel,
                                    controlsBuilder: (
                                      BuildContext context ,{VoidCallback onStepContinue,VoidCallback onStepCancel}){
                                         return SingleChildScrollView(
                                           scrollDirection: Axis.horizontal,
                                           child: Row(
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
                                           ),
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
        ),
      );


  }

  void assign() async { 

      bool checkthis = true;
      var idyours = userData['id'].toString();
      var data = {
        "transactionId" : '${widget.getID}',
        "riderId" :  idyours,
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
                  onPressed: () async{
                     bool checkthis = true;
      var idyours = userData['id'].toString();
      var data = {
        "transactionId" : '${widget.getID}',
        "riderId" :  idyours,
      };

      var response = await ApiCall().assignRiders(data, '/assignRider');
      var body = json.decode(response.body);
      if(body == true){
        print("TRUE");
        SharedPreferences localStore = await SharedPreferences.getInstance();
        localStore.setBool("cuurentIdtrans", checkthis);
        localStore.setString("menuplustrans", "${widget.getID}");
        localStore.setString("playerIDS", "${widget.playerId}");
      }else{
        print("FALSE");
      }
      setState(() {
      available = !available;
      menuHide = !menuHide;
      backTF = !backTF;
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

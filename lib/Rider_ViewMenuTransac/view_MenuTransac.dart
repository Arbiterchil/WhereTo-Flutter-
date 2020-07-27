import 'dart:convert';
import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
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

  const ViewMenuOnTransac({Key key, this.getID, this.gotTotal, this.deliverTo, this.restaurantName}) : super(key: key);


  
  
  @override
  _ViewMenuOnTransacState createState() => _ViewMenuOnTransacState();
}



class _ViewMenuOnTransacState extends State<ViewMenuOnTransac> {



var totalAll;
var deliverFee;
var priceTotal = 0;
var quantityTotal = 0;
var totals;
var userData;

@override
  void initState() {
    _getUserInfo();
    super.initState();
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

    

    Widget _viewMenus(){

        return Container(
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
        );

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
                                      child: DesignButton(
                                        height: 55,
                                        width: 55,
                                        color: Color(0xFF398AE5),
                                        offblackBlue: Offset(-4, -4),
                                        offsetBlue: Offset(4, 4),
                                        blurlevel: 4.0,
                                        icon: Icons.drive_eta,
                                        iconSize: 30.0,
                                        onTap: ()  {
                                       
                                     
                                    },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      SizedBox(height: 40.0,),
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
                       SizedBox(height: 10.0,),

                      ],
                    ),
                    ),
                    ),
              ),
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
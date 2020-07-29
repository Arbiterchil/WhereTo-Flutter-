import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MShowStep extends StatefulWidget {



  @override
  _MShowStepState createState() => _MShowStepState();
}

    



class _MShowStepState extends State<MShowStep> {

  var idgetter;

  @override
  void initState() {
    
    super.initState();
  }




 Future<List<RiverMenu>> getMenuTransaction() async {

        SharedPreferences local = await SharedPreferences.getInstance();
        
          var check = local.getBool("cuurentIdtrans");
        if(check !=null ){

            if(check){
                  idgetter = local.getString("menuplustrans");
                  print(idgetter);
            }else{
              print("No Id Getter.");
            }

        }
       

        final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/$idgetter');
        // final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/2');
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


  @override


  Widget build(BuildContext context) {
    return Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: getMenuTransaction(),
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
}
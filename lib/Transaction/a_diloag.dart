import 'dart:ui';

import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/BarangaylocalList/barangay_stream.dart';
import 'package:WhereTo/Transaction/MyOrder/ComputationFee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styletext.dart';
import 'MyOrder/payOrder.dart';

class DialogForMico extends StatefulWidget {

  final String restaurantId;

  const DialogForMico({this.restaurantId});

  

 

  @override
  _DialogForMicoState createState() => _DialogForMicoState();
}

class _DialogForMicoState extends State<DialogForMico> {
   String selectPerson;
  final formkey = GlobalKey<FormState>();
  TextEditingController address = TextEditingController();
    @override
  void initState() {
    super.initState();
     bararangStream..getBarangayListFormDb();
  }
  @override
  void dispose() {
    super.dispose();
     bararangStream..drainStreamData();
  }

Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
Widget _loading(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }
Widget _view(BaranggayRespone respone){
    List<Barangays> bararangs = respone.bararangSaika;
    if(bararangs.length == 0 ){
          return Container(
            child: Text('Come Back Later.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{            
                return Container(
                    width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ),
              ),
              child: Padding(
               padding: const EdgeInsets.only(left: 10),
               child: DropdownButtonHideUnderline(
                 child: Stack(
                   children: [
                     Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Icon(
                                Icons.place,
                                color: Color(0xFF0F75BB),
                              ),
                            )),
                    Padding(
                       padding: const EdgeInsets.only(left: 30),
                       child: ButtonTheme(
                         alignedDropdown: true,
                         child: DropdownButton<String>(
                             isExpanded: true,
                             hint:  Text(
                                    "Select Barangay",
                                    style: TextStyle(
                                        color: Color(0xFF0F75BB),
                                        fontFamily: 'Gilroy-light'),
                                  ),
                                   dropdownColor: Colors.white,
                                   icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:Color(0xFF0F75BB),
                                  ),
                                
                             items: bararangs.map((e) {
                                return new DropdownMenuItem(
                                  child: Text(e.barangayName,
                                  style: TextStyle(
                                            color: Color(0xFF0F75BB),
                                            fontFamily: 'Gilroy-light'),),
                                            value: e.id.toString(),
                                );
                             }).toList(),
                               value:selectPerson,
                               
                             onChanged: (val){
                              //  setState(()=>selectPerson = val);
                              setState(() {
                                selectPerson = val;
                                print(val);
                              });
                             },
                             )
                       ),
                      ),        
                   ],
                 ),
               ),
                ),
                );
        }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -50,
              child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: SpinKitChasingDots(
                  color: wheretoDark,
                  size: 30,
                ),
              ),
            )),
            Container(
              height: 360,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.only(top: 50),
                  child: Text("Please Fill up this.",
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 18
                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                   StreamBuilder<BaranggayRespone>(
      stream: bararangStream.subject.stream,
      builder: (context,AsyncSnapshot<BaranggayRespone> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              
              return _view(snaphot.data);
              
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      }),
      SizedBox(height: 20,),
      Form(
        key: formkey,
        child: TextFormField(
          controller: address,
          decoration: InputDecoration(
            labelText: "Delivery Address",
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide()
            ),
          ),
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontFamily: 'Gilroy-light'
          ),
          validator: (val){
            if(val.length == 0){
              return "Text Cannot Be Empty";
            }else{
              return null;
            }
          },
        ),
      ),
      SizedBox(height: 20,),
      Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(40)), 
                            ),
                            child: RaisedButton(
                              color: pureblue,
                              splashColor: wheretoDark,
                              child: Center(
                                child: Text("Next",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12
                                    ),
                                    ),
                              ),
                              shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(40)), 
                              ),
                              onPressed:() async{
                                if(selectPerson == null){
                                  print("stop");
                                }else{
                                  if(formkey.currentState.validate()){
                                  formkey.currentState.save();
                                  double fee =await ComputationFee().getFee(selectPerson);
                                                       if(fee!=null){
                                                        
                                                         Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                         PayOrder(
                                                          fee: fee,
                                                          restauID:widget.restaurantId,
                                                          deliveryTypedaw: address,
                                                          )));
                                                       }
                                }
                                }
                              }),
                          ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
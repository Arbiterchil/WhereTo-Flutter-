import 'dart:ui';

import 'package:WhereTo/Admin/AddCityfran/formEditbaran/editbloc.dart';
import 'package:flutter/material.dart';

import '../../../styletext.dart';

class ChangeChargebaran extends StatefulWidget {

  final int id;

  const ChangeChargebaran({Key key, this.id}) : super(key: key);

  @override
  _ChangeChargebaranState createState() => _ChangeChargebaranState(id);
}

class _ChangeChargebaranState extends State<ChangeChargebaran> {
  final int id;

  _ChangeChargebaranState(this.id);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.white,
          child: Stack(
            overflow: Overflow.visible,
           alignment: Alignment.topCenter,
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
                child: Icon(
                  Icons.location_city,
                  color: wheretoDark,
                  size: 70,
                ),
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Text("Edit Charges",
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 16
                  ),
                  ),
                  SizedBox(height: 16,),
                  textfel(eitbaran),
                  SizedBox(height: 16,),
                  button(id),

                    ],
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
    );
  }

   Widget textfel(EditSeaBaran ads){
   return Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: StreamBuilder(
                stream: ads.bans, 
                builder: (context,snaps){
                   return TextField(
          autocorrect: true,
                keyboardType: TextInputType.text,
                cursorColor: wheretoDark,
                obscureText: false,
                onChanged: ads.chanban,
                style: TextStyle(
                  
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  
                ),
          decoration: InputDecoration(
             prefixIcon: Icon(
                    Icons.location_city,
                    color: wheretoDark,
                  ),
                  hintText: "Charge",
                  hintStyle: TextStyle(
                  color: wheretoDark,
                  fontFamily: 'Gilroy-light',
                  ),
            errorText: snaps.error,
            labelText: "Edit Charge",
            fillColor: wheretoDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide()
            ),
          ),
        );
                }),
            );
  }
    Widget button(int id){
    return Container(
      height: 40,
      width: 120,
      child: RaisedButton(
        splashColor: Colors.white,
        color: wheretoDark,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
        child: Center(
          child: Text("Add",
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Gilroy-light'
          ),
          ),
        ),
        onPressed: ()=> doneSave(eitbaran,id)),
    );
  }
  doneSave(EditSeaBaran ads,int id) async{
    ads.editbaran(id);
    Navigator.pop(context);
  }
}
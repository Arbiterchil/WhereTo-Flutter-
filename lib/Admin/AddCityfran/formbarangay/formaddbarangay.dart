import 'package:WhereTo/A1_NewSingleBottomNav/Single_customfield/single.customField.dart';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/AddCityfran/city_forms.dart';
import 'package:WhereTo/Admin/AddCityfran/formbarangay/formbararangBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../styletext.dart';

class FormAddbararang extends StatefulWidget {

  final int id;
  final String cityname;

  const FormAddbararang({Key key, this.id, this.cityname}) : super(key: key);

  @override
  _FormAddbararangState createState() => _FormAddbararangState(id,cityname);
}

class _FormAddbararangState extends State<FormAddbararang> {
 final int id;
  final String cityname;
  _FormAddbararangState(this.id, this.cityname);


  FocusNode barans;
  FocusNode charge;


  @override
  void initState() {
    super.initState();
    barans = FocusNode();
    charge = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                            height: 50,
                            width: 50,
                            child: RaisedButton(
                              splashColor: Colors.white,
                              color: wheretoDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)
                              ),
                              child: Center(
                                child: Text("X",
                                style: TextStyle(
                                  fontFamily: "Gilroy-ExtraBold",
                                  fontSize: 20,
                                  color: Colors.white
                                ),
                                ),
                              ),
                              onPressed: ()=> Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_)=> SeacrhFormCitywithAdd())),),
                     
                      ),
                     
                    ],
                  )
                ),
                 SizedBox(height: 20,),
                      Text(cityname,style: TextStyle(
                        color: wheretoDark,
                        fontSize: 22,
                        fontFamily: 'Gilroy-ExtraBold'
                      ),),
                      SizedBox(height: 80,),
                      barangayNama(formB),
                      SizedBox(height: 10,),
                      chargeint(formB),
                      SizedBox(height: 10,),
                      button(formB),
              ],
            ),
          ),
        )),
    );
  }

  Widget barangayNama(FormAddbaran formb){
    return CustomTextFieldFixStyle(
      stream: formb.barangayNamein,
      obsecure: false,
      onchangeTxt:formb.changebaran,
      iconText: Icons.location_history,
      type: TextInputType.name,
      hintTxt: "Baranggay Name",
      labelText: "Baranggay",
      nodes: barans ,
      actions: TextInputAction.next,
      submit: (_)=>FocusScope.of(context).requestFocus(charge),
    );
  }
  Widget chargeint(FormAddbaran formb){
     return CustomTextFieldFixStyle(
      stream: formb.charges,
      obsecure: false,
      onchangeTxt:formb.changecharge,
      iconText: Icons.location_history,
      type: TextInputType.number,
      hintTxt: "Charge",
      labelText: "Charge",
      nodes: charge ,
      actions: TextInputAction.done,
      submit: (_)=>FocusScope.of(context).requestFocus(FocusNode()),
    );
  }
  Widget button(FormAddbaran formb){
    return StreamBuilder(
      stream: formb.subs,
      builder: (context,snaps)
      => Container(
        height: 60,
        width: 120,
        child: RaisedButton(
          color: wheretoDark,
          splashColor: Colors.white,
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),),
             child:Center(
                            child: Text("Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy-light'
                            ),
                            ), 
                        ),
          onPressed: snaps.hasData
          ?() => done(formb,id):null),
      ),
    );
  }
  done(FormAddbaran formb,int id) async{
    showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPulse(color: wheretoDark,size: 80,),
        labelHeader: "Notice:",
        message: "Please Double Check the name and Charge",
        buttTitle1: "Add",
        buttTitle2: "Cancel",
        noFunc: ()=>Navigator.pop(context),
        yesFunc: (){
          formb.saveinputedBaranagy(id);
          Navigator.pop(context);
        },
        showorNot1: true,
        showorNot2: true,
      ),
      
      );
  }

}
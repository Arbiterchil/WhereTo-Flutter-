import 'package:flutter/material.dart';

class DialogShow extends StatefulWidget {


   final Function no;
   final Function yes;
   final String label;

  const DialogShow({Key key, this.no, this.yes, this.label}) : super(key: key);


  
  @override
  _DialogShowState createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  @override
  Widget build(BuildContext context) {
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustom(context),
    );      
    
  }

  mCustom(BuildContext context){

      return Container(
        height: 300.0,
        width: 200.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
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
                      color: Color(0xFF398AE5),),

                  ),
                  Positioned(
                    top: 50.0,
                    left: 94.0,
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
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
                child: Text(widget.label,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'OpenSans'
                ),
                
                ),),
                SizedBox(height: 25.0,),
                 
            ],
        ),



      );

  }

}
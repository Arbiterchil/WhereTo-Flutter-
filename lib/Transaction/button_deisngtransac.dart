import 'package:flutter/material.dart';

class ButtonPlaceOrder extends StatefulWidget {

final Color color;
  final double blurlevel;
  final Offset offsetBlue;
final Offset offblackBlue;
final double height;
final double width ; 
final IconData icon;
final double iconSize;
final Function onTap;

  const ButtonPlaceOrder({Key key, this.color, this.blurlevel, this.offsetBlue, this.offblackBlue, this.height, this.width, this.icon, this.iconSize, this.onTap}) : super(key: key);

  @override
  _ButtonPlaceOrderState createState() => _ButtonPlaceOrderState();
}

class _ButtonPlaceOrderState extends State<ButtonPlaceOrder> {
 
 bool isPressDown =false;
     void onPressUpnow(PointerUpEvent event){
       setState(() {
         isPressDown =false;
       });
     }
     void onPressDownnow(PointerDownEvent event){
       setState(() {
         isPressDown = true;
       });
     }
 
  @override
 
  Widget build(BuildContext context) {
   return Listener(
      onPointerDown: onPressDownnow,
      onPointerUp: onPressUpnow,
      child: GestureDetector(
        onTap: widget.onTap,
        child: isPressDown? Container(
          height: widget.width,
          width: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: widget.blurlevel,
                offset: Offset(-4, -4),
                color: Colors.white.withOpacity(.7)
              ),
              BoxShadow(
                blurRadius: widget.blurlevel,
                offset: Offset(4, 4),
                color: Colors.grey[500].withOpacity(.15)
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: widget.blurlevel,
                        offset: widget.offsetBlue,
                        color: Colors.grey.shade500
                        // withOpacity(.7)
                      ),
                      BoxShadow(
                        blurRadius: widget.blurlevel,
                        offset: widget.offblackBlue,
                        color: Colors.grey[500].withOpacity(.25)
                      ),
                    ],
                  ),
                  child: Icon(widget.icon,
                  size: widget.iconSize,
                  color: Colors.amber,),
                ),
              ),
            ),
          ),
        ): Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color:Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
               BoxShadow(
                                                      color: Colors.grey[500],
                                                      offset: Offset(4.0, 4.0),
                                                      blurRadius: 15.0,
                                                      spreadRadius: 1.0

                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      offset: Offset(-4.0, -4.0),
                                                      blurRadius: 15.0,
                                                      spreadRadius: 1.0
                                                    )
            ],
          ),
          child: Icon(
            widget.icon,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}